FROM openjdk:11-jdk-slim AS build
WORKDIR /app

COPY . .

RUN chmod +x gradlew \
    && ./gradlew clean war --no-daemon -x test

FROM tomcat:9-jdk11
WORKDIR /usr/local/tomcat/webapps

RUN rm -rf ROOT
COPY --from=build /app/build/libs/class_schedule.war ./ROOT.war

EXPOSE 8080