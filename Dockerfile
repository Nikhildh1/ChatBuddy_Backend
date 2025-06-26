# Start with a Maven builder image to build the app
FROM maven:3.9.4-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build the project (skip tests to make it faster)
RUN mvn clean package -DskipTests

# --------- Create a smaller image for running ---------

# Use a lightweight JDK image for running the app
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy only the built jar from the builder image
COPY --from=build /app/target/*.jar app.jar

# Expose default Spring Boot port
EXPOSE 8080

# Start the app
CMD ["java", "-jar", "app.jar"]