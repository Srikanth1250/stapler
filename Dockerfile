# Stage 1: Maven build with Java 17
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn clean install -DskipTests

# Stage 2: Final lightweight image with just plugin artifact
FROM eclipse-temurin:17-jre

WORKDIR /plugin
COPY --from=builder /app/target/*.hpi .

CMD ["echo", "Jenkins Plugin built successfully."]
