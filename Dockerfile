# Stage 1: Build ứng dụng
FROM maven:3.8.7-openjdk-21 AS build
WORKDIR /build

# Copy file pom.xml trước để cache dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy toàn bộ mã nguồn vào container
COPY src ./src

# Build ứng dụng
RUN mvn clean package -DskipTests

# Stage 2: Chạy ứng dụng
FROM openjdk:21-jdk-slim
WORKDIR /app

# Copy file JAR từ stage build
COPY --from=build /build/target/*.jar app.jar

# Expose port (thay đổi tùy theo ứng dụng)
EXPOSE 8080

# Run ứng dụng
CMD ["java", "-jar", "app.jar"]
