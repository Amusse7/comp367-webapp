FROM tomcat:9-jdk11

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Install Maven
RUN apt-get update && \
    apt-get install -y maven

WORKDIR /app

# Copy the project files
COPY . .

# Build the project
RUN mvn clean package

# Copy the WAR file to Tomcat's webapps directory
RUN cp target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
