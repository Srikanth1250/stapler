# Stage 1: Build the Jenkins plugin
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy POM and source code
COPY pom.xml .
COPY src ./src

# Build the plugin (skip tests for speed)
RUN mvn clean install -DskipTests

# Stage 2: Final lightweight image with just the .hpi plugin
FROM eclipse-temurin:17-jre

WORKDIR /plugin

# Copy built .hpi from the builder image
COPY --from=builder /app/target/*.hpi .

# Optional: list the contents
CMD ["ls", "-l", "/plugin"]
