FROM maven:3.9.3-ibmjava-8 as builder

WORKDIR / myapp

COPY . .

RUN mvn install





FROM tomcat:9

COPY --from=builder /myapp/target/*.war /usr/local/tomcat/webapps

EXPOSE 8080:8080