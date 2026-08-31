# Build stage
FROM maven:3.9.9-eclipse-temurin-11 AS build

WORKDIR /workspace

COPY pom.xml .

COPY src ./src

RUN mvn -B -DskipTests clean package


# Tomcat stage
FROM tomcat:9.0-jdk11-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /workspace/target/ecommerce.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]