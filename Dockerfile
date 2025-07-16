# Stage 1: Build the plugin
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src

# Build the plugin (this step may fail if your plugin code has issues)
RUN mvn clean install -DskipTests

# Stage 2: Final image with only plugin artifact
FROM eclipse-temurin:17-jre

WORKDIR /plugin
COPY --from=builder /app/target/*.hpi .

CMD ["echo", "Jenkins plugin built successfully."]
