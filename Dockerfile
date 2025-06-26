# Use an official lightweight OpenJDK base image
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Make mvnw executable & build the project
RUN chmod +x mvnw && ./mvnw clean install -DskipTests

# Expose the port your app runs on (default Spring Boot port is 8080)
EXPOSE 8080

# Run the Spring Boot app
CMD ["java", "-jar", "target/*.jar"]