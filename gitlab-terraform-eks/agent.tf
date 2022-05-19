resource "kubernetes_namespace" "gitlab_agent" {
  metadata {
    name = var.agent_namespace
  }
}

resource "kubernetes_service_account" "gitlab_agent" {
  metadata {
    name      = "gitlab-agent"
    namespace = var.agent_namespace
  }
}

resource "kubernetes_cluster_role_binding" "gitlab_agent" {
  metadata {
    name = "gitlab-agent-cluster-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.gitlab_agent.metadata[0].name
    namespace = var.agent_namespace
  }
}

resource "kubernetes_secret" "gitlab_agent" {
  metadata {
    name      = "gitlab-agent-token"
    namespace = var.agent_namespace
  }

  data = {
    token = var.agent_token
  }
}

resource "kubernetes_deployment" "gitlab_agent" {
  metadata {
    name      = "gitlab-agent"
    namespace = var.agent_namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "gitlab-agent"
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = 0
        max_unavailable = 1
      }
    }

    template {
      metadata {
        annotations = {
          "prometheus.io/path"   = "/metrics"
          "prometheus.io/port"   = "8080"
          "prometheus.io/scrape" = true
        }

        labels = {
          app = "gitlab-agent"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.gitlab_agent.metadata[0].name

        container {
          image = "registry.gitlab.com/gitlab-org/cluster-integration/gitlab-agent/agentk:${var.agent_version}"
          name  = "agent"

          args = [
            "--token-file=/config/token",
            "--kas-address",
            var.kas_address
          ]

          env {
            name = "POD_NAMESPACE"

            value_from {
              field_ref {
                field_path = "metadata.namespace"
              }
            }
          }

          env {
            name = "POD_NAME"

            value_from {
              field_ref {
                field_path = "metadata.name"
              }
            }
          }

          liveness_probe {
            http_get {
              path = "/liveness"
              port = 8080
            }

            initial_delay_seconds = 15
            period_seconds        = 20
          }

          readiness_probe {
            http_get {
              path = "/readiness"
              port = 8080
            }

            initial_delay_seconds = 5
            period_seconds        = 10
          }

          volume_mount {
            name       = "token-volume"
            mount_path = "/config"
          }
        }

        volume {
          name = "token-volume"
          secret {
            secret_name = kubernetes_secret.gitlab_agent.metadata[0].name
          }
        }
      }
    }
  }
}
