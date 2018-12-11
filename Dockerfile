FROM tomcat:9.0.5-jre8

# Run the environment intense user $UID=9001& $GID=9001
ENV RUN_USER            intense -u 9001
ENV RUN_GROUP           intense -g 9001
RUN groupadd -r ${RUN_GROUP} && useradd -g ${RUN_GROUP} -d ${CATALINA_HOME} -s /bin/bash ${RUN_USER}
RUN chown -R intense:intense $CATALINA_HOME


# Add Binary files
ADD context.xml /usr/local/tomcat/webapps/host-manager/META-INF/context.xml
ADD context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml
ADD tomcat-users.xml /usr/local/tomcat/conf/
ADD server.xml /usr/local/tomcat/conf/
ADD index.jsp /usr/local/tomcat/webapps/ROOT/

# remove unwanted files
RUN rm -rf /usr/local/tomcat/webapps/examples
RUN rm -rf /usr/local/tomcat/webapps/docs


# rename the manager and host-manager
RUN mv /usr/local/tomcat/webapps/manager /usr/local/tomcat/webapps/controller
RUN mv /usr/local/tomcat/webapps/host-manager /usr/local/tomcat/webapps/host-controller
# hide the serverinfo
RUN mkdir -p /usr/local/tomcat/lib/org/apache/catalina/util
RUN touch /usr/local/tomcat/lib/org/apache/catalina/util/ServerInfo.properties
RUN echo "server.info=INMARSAT" > /usr/local/tomcat/lib/org/apache/catalina/util/ServerInfo.properties

