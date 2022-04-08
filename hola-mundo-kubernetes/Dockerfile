FROM openjdk:8-jdk-alpine

ARG JAR_FILE=hola_mundo.jar

COPY ${JAR_FILE} app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]