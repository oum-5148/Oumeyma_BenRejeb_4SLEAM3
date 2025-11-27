FROM openjdk:17.0.1-jdk-slim
WORKDIR /app
COPY target/*.jar /app.jar
EXPOSE 
