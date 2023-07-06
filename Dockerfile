FROM maven:3.9.3-ibmjava-8 as builder

WORKDIR / myapp

COPY . .

RUN mvn install


EXPOSE 8080:8080


FROM tomcat:9

COPY --from=builder /myapp/war /usr/local/tomcat/webapps
