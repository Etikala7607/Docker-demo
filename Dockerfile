FROM maven:3.9.3-ibmjava-8 as builder

WORKDIR / app

COPY . .

RUN mvn install





FROM tomcat:9

COPY --from=builder /app/target/sample-1.0.3.jar 

EXPOSE 8080:8080


CMD ["java", "-jar", "sample-1.0.3.jar"]