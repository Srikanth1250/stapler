# Stage 1: Build Jenkins plugin
FROM maven:3.9.6-eclipse-temurin-11 AS builder

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean install -DskipTests

# Stage 2: Only the plugin artifact
FROM alpine:3.20

WORKDIR /plugin

COPY --from=builder /app/target/*.hpi ./my-jenkins-plugin.hpi

CMD ["ls", "-l", "/plugin"]
