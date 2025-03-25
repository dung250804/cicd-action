FROM openjdk:21-jdk-slim

WORKDIR /app

ADD target/api-springboot-0.0.1-SNAPSHOT.jar /app/springboot-image.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "springboot-image.jar"]
