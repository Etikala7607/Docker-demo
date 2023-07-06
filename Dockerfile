FROM maven:3.9.3-ibmjava-8 as builder

WORKDIR /app

COPY . .

RUN mvn clean package

FROM openjdk:8-jre-alpine

WORKDIR /app

COPY --from=builder /app/target/sample-1.0.3.jar .

EXPOSE 8080

CMD ["java", "-jar", "sample-1.0.3.jar"]
In this case, the Dockerfile will build a JAR file using Maven, and then copy the JAR file to the final Docker image based on OpenJDK. The container will expose port 8080, and the CMD command will run the application using the JAR file.

Option 2: Build a WAR file for Tomcat
If your intention is to build a WAR file for deployment on Tomcat, you will need to make some adjustments to your project's pom.xml file. Specifically, you need to include the spring-boot-starter-web dependency and set the packaging type to war. Here's an example of an updated pom.xml file:

xml
Copy code
<!-- ... -->
<packaging>war</packaging>
<!-- ... -->
<dependencies>
  <!-- ... -->
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
  </dependency>
  <!-- ... -->
</dependencies>
<!-- ... -->
After updating the pom.xml file, you can use the following Dockerfile to build the WAR file and deploy it on Tomcat:

Dockerfile
Copy code
FROM maven:3.9.3-ibmjava-8 as builder

WORKDIR /app

COPY . .

RUN mvn clean package

FROM tomcat:9

COPY --from=builder /app/target/sample-1.0.3.war /usr/local/tomcat/webapps/sample.war

EXPOSE 8080