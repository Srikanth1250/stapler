# Stage 1: Build the plugin
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean install -DskipTests

# Stage 2: Extract the .hpi artifact
FROM eclipse-temurin:17-jre

WORKDIR /plugin
COPY --from=builder /app/target/*.hpi .

CMD ["ls", "-l", "/plugin"]
