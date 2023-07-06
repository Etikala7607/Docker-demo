FROM maven:3.9.3-ibmjava-8 as builder

WORKDIR /app

COPY . .

RUN mvn clean package

FROM openjdk:8-jre-alpine

WORKDIR /app

COPY --from=builder /app/target/sample-1.0.3.jar .

EXPOSE 8080

