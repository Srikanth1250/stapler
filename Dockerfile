# Stage 1: Build Jenkins plugin
FROM maven:3.9.6-eclipse-temurin-17 as builder

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn clean install -DskipTests

# Stage 2: Final minimal image with just the plugin
FROM eclipse-temurin:17-jre

WORKDIR /plugin
COPY --from=builder /app/target/my-jenkins-plugin.hpi .

CMD ["echo", "Plugin built: my-jenkins-plugin.hpi"]
