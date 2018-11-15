FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn package

FROM tomcat:9.0-jre8-alpine
RUN rm -Rf /usr/local/tomcat/webapps/ROOT
COPY --from=MAVEN_TOOL_CHAIN /tmp/target/gcptest*.war $CATALINA_HOME/webapps/ROOT.war
