# Stage 1: Build the Jenkins plugin
FROM maven:3.9.6-eclipse-temurin-11 AS builder

# Set working directory
WORKDIR /app

# Copy Maven project files
COPY pom.xml .
COPY src ./src

# Build plugin and skip tests for speed
RUN mvn clean install -DskipTests

# Stage 2: Runtime (optional – if you only want to keep the .hpi file)
FROM alpine:3.20

WORKDIR /plugin

# Copy .hpi file from builder stage
COPY --from=builder /app/target/*.hpi ./my-jenkins-plugin.hpi

# Entry point just to inspect or mount the plugin
CMD ["ls", "-l", "/plugin"]
