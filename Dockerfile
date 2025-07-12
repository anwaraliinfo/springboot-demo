# Use an official Java runtime as base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the JAR file
COPY target/demo-1.0.0.jar app.jar

# Expose port
EXPOSE 9090

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
