# Stage 1: Build Jenkins plugin using Maven and Java 11
FROM maven:3.9.6-eclipse-temurin-11 AS builder

WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build Jenkins plugin (skip tests for faster build)
RUN mvn clean install -DskipTests

# Stage 2: Final image with just the .hpi file
FROM alpine:3.20

WORKDIR /plugin

# Copy the plugin from the build stage
COPY --from=builder /app/target/*.hpi ./my-jenkins-plugin.hpi

# Default command to inspect the .hpi file
CMD ["ls", "-l", "/plugin"]
