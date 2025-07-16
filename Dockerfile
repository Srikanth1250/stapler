# Stage 1: Build the Jenkins plugin
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn clean install -DskipTests

# Stage 2: Final image (optional, just copies the built plugin)
FROM alpine:3.18

WORKDIR /plugin
COPY --from=builder /app/target/*.hpi .

CMD ["ls", "-l"]
