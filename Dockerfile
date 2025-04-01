# Stage 1: Build ứng dụng
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /build
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package

# Stage 2: Run ứng dụng
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY --from=build /build/target/*.jar app.jar
CMD ["java", "-jar", "app.jar"]
