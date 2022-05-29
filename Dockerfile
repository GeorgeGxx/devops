#Download base image ubuntu 16.04
#FROM ubuntu:16.04

#Download base image ubuntu 20.04
FROM ubuntu:20.04

#Update Ubuntu Software repository
RUN apt-get update && apt upgrade -y
#RUN apt-get upgrade -y

#Install Java
#RUN apt install openjdk-8-jdk -y
RUN apt install openjdk-11-jdk -y
RUN java -version

#Install maven
RUN apt-get install maven -y

#install wget 
RUN apt-get install wget -y

#install gnupg2
RUN apt-get update && apt-get install -y gnupg2

#install Jenkins
RUN wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
#RUN apt-add-repository "deb https://pkg.jenkins.io/debian-stable binary/"
RUN sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
#RUN echo deb https://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list
RUN apt-get install -y apt-transport-https ca-certificates
RUN apt-get update -y
RUN apt-get install jenkins -y
RUN apt-get update -y

#Descargar el paquete desde la página de Jenkins CI y agregar las llaves del repositorio a la lista de sources.
#RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | apt-key add -

#Agrega Jenkins a la lista de sources:
#RUN sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

#Add support for https apt sources
#RUN apt-get install -y apt-transport-https ca-certificates

#Actualizar el índice de paquetería
#RUN apt-get update -y

#Instalar Jenkins: 
#RUN apt-get install jenkins -y

CMD jenkins status
#CMD systemctl enable jenkins
#CMD /etc/init.d/jenkins start
#EXPOSE 8080:8080