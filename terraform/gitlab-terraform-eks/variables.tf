variable "region" {
  default     = "us-east-2"
  description = "AWS region"
}

variable "cluster_name" {
  default     = "gitlab-terraform-eks"
  description = "EKS Cluster name"
}

variable "cluster_version" {
  default     = "1.21"
  description = "Kubernetes version"
}

variable "instance_type" {
  default     = "t3.small"
  description = "EKS node instance type"
}

variable "instance_count" {
  default     = 3
  description = "EKS node count"
}

variable "agent_version" {
  default     = "v14.8.1"
  description = "Agent version"
}

variable "agent_namespace" {
  default     = "gitlab-agent"
  description = "Kubernetes namespace to install the Agent"
}

variable "agent_token" {
  description = "Agent token (provided after registering an Agent in GitLab)"
  sensitive   = true
}

variable "kas_address" {
  description = "Agent Server address (provided after registering an Agent in GitLab)"
}
