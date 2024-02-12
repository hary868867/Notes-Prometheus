FROM maven:3.5.4-jdk-8-slim AS builder

WORKDIR /usr/src/jsfapp 
COPY src/java/jsfapp/pom.xml .
RUN mvn -B -f pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency:resolve

COPY src/java/jsfapp .
RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml package -DskipTests

# app image
FROM tomcat:8.5-jre8-alpine

RUN rm -r -f /usr/local/tomcat/webapps 
WORKDIR /usr/local/tomcat/webapps/ROOT 
COPY --from=builder /usr/src/jsfapp/target/jsfapp/ .