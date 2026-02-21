# ---------- Build Stage ----------
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /build

COPY pom.xml .
RUN mvn -B -ntp dependency:go-offline

COPY src ./src
RUN mvn -B -ntp clean package -DskipTests

# ---------- Runtime Stage ----------
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Security: non-root user
RUN addgroup -S app && adduser -S app -G app
USER app

COPY --from=builder /build/target/*jar app.jar

EXPOSE 8080

ENTRYPOINT ["java",
 "-XX:+UseContainerSupport",
 "-XX:MaxRAMPercentage=75.0",
 "-XX:+ExitOnOutOfMemoryError",
 "-jar","app.jar"]
