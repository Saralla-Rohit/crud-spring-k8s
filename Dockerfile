FROM maven:3.9-eclipse-temurin-17 AS build

#sets /app as the working directory inside the container.
WORKDIR /app

#copy pom file into container root
COPY pom.xml .
#create the new folder inside root with src inside container directory
COPY src ./src

RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /app/target/springboot-crud-k8s.war app.war

EXPOSE 8082

ENTRYPOINT ["java","-jar","app.war"]