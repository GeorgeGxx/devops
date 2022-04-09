# Docker, Kubernetes, Jenkins, Terraform & Confluent Labs

## Comandos Docker

docker --version

docker info

docker -v

-------------------------------

- Enumerar imagenes

docker images

docker images -a

- Enumerar contenedores

docker ps

docker ps -a

docker ps -l

- Crear una imagen por Dockerfile

docker build -t "nombre_imagen"

docker build -t spring-boot-docker:0.0.2 .

docker build -t imagen-devpredator-animes .

docker build -t "jenkins:dockerfile" .

ls -la

- Crea un contenedor en imagen

docker run -p 8090:9000 nombre_imagen

- Ejecuta un contenedor

docker run "nombre_imagen"

docker run -it ubuntu //Ejecutar container docker

docker run -it openjdk:11 bash

docker run --name spring-boot-docker -p 80:80 --detach spring-boot-docker:0.0.2

docker run -i -t almalinux

docker run -u root -i -t -p 18081:8081 -d --name jenkins-container <<imageId>> /bin/bash
docker run -u root -i -t -p 18081:8081 -d --name jenkins-container b6f507652425 /bin/bash

- Detener contenedor

docker stop spring-boot-docker

docker stop jenkins-container jenkins-container

- Iniciar contenedor detenido

docker start 1c08a7a0d0e4 //CONTAINER ID 1c08a7a0d0e4

docker start <<containerId>>
docker exec -it <<containerId>> /bin/bash

- Eliminar contenedor

docker rm jenkins-container jenkins-container

docker rm youthful_curie //NAMES youthful_curie

- Confirmar cambios aplicados a una imagen de Docker en un contenedor

docker commit -m "What you did to the image" -a "Author Name" container_id repository/new_image_name

docker commit -m "added Node.js" -a "sammy" d9b100f2f636 sammy/ubuntu-nodejs

docker images

- Descargar imagenes

docker pull almalinux

- Introducir imágenes de Docker en un repositorio de Docker / DockerHub

docker login -u docker-registry-username

docker tag sammy/ubuntu-nodejs docker-registry-username/ubuntu-nodejs

docker push docker-registry-username/docker-image-name

docker push sammy/ubuntu-nodejs

-------------------------------

- Instalaciones complementarias Windows

https://docs.microsoft.com/es-es/windows/wsl/install-win10#step-4---download-the-linux-kernel-update-package

https://docs.microsoft.com/es-es/windows/wsl/user-support

- Instalar Docker en Ubuntu

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-es

--------------------------------

- Comandos Ubuntu Docker

sudo apt update && sudo apt upgrade

cat /etc/group

sudo gpasswd -a ubuntu docker

---------------------------------

## Jenkins

- Instalar Jenkins

java -jar jenkins.war

7380713d6c26462ab5b8c1850c031f6c

-------------------------------------

Instalar Jenkins en Docker (Dockerfile)

- #Download base image ubuntu 16.04
FROM ubuntu:16.04

- #Update Ubuntu Software repository
RUN apt-get update

- #Install Java
RUN apt install openjdk-8-jdk -y

- #Install maven
RUN apt-get install maven -y

- #install wget 
RUN apt-get install wget -y

- #install gnupg2
RUN apt-get update && apt-get install -y gnupg2

- #Descargar el paquete desde la página de Jenkins CI y agregar las llaves del repositorio a la lista de sources.
RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | apt-key add -

- #Agrega Jenkins a la lista de sources:
RUN sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

- #Add support for https apt sources
RUN apt-get install -y apt-transport-https ca-certificates

- #Actualizar el índice de paquetería
RUN apt-get update

- #Instalar Jenkins: 
RUN apt-get install jenkins -y

CMD /etc/init.d/jenkins start
EXPOSE 18081:8081