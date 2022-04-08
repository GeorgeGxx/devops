# Dockerización de un Entorno de Integración Continua

## Objetivo:

Disponer de un entorno de integración continua, con los siguientes componentes:

* Jenkins
  * Versión 1 Final
  * Versión 2
  * Versión 1.609.3
* Nexus 3
* Sonar 5.6.1

## Preparación del entorno:

##### Descarga el proyecto

```
git clone https://github.com/jorgepacheco/docker-integracion-continua
```
##### Configuración de las versiones

Se pueden configurar las versiones de las diferentes herramientas que componen el entorno, para ello editaremos el fichero ***.env***

```
JENKINS_VERSION=1.609.3
NEXUS_VERSION=latest
SONAR_VERSION=5.6.1
```
La versión de Jenkins es la que más limitaciones presenta ya que usamos un ***Dockerfile*** específico (ya que añadimos la jdk y maven a la imagen) por lo que la variable  ***JENKINS_VERSION*** sólo puede tomar lo siguientes valores:

* 1_609_3 --> Versión específica de Jenkins versión 1:
* 1_Final --> Última versión de la rama 1.
* latest --> Última versión disponible de la rama 2.

Para ***Sonar*** y ***Nexus*** se puede seleccionar la versión que necesitemos (siempre y cuando este disponible en su ***Docker Hub***)

##### Configuración de maven

A imagen de jenkins que utilizamos, se le aprovisiona con MAVEN y podemos personalizar esta versión. Para ello modificamos el docker-compose.yml y modificamos la variable MAVEN_VERSION:

```
jenkins:
  build: ./jenkins-${JENKINS_VERSION}
  container_name: jenkins
  environment:
    - MAVEN_VERSION=3.0.4
```


## Construcción del entorno

```
docker-compose build
```

## Levantar el entorno

```
docker-compose up -d
```


### URL's de Acceso

```
jenkins: http://ip-docker-machine:18080
nexus: http://ip-docker-machine:18081
sonar: http://ip-docker-machine:19000
```
