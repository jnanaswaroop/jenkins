#! /bin/bash
# On root run the following command
apt update -y
apt upgrade -y
apt install default-jdk -y
java -version
apt install maven -y
sudo wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.7/bin/apache-tomcat-10.1.7.tar.gz
sudo tar -xvzf apache-tomcat-10.1.7.tar.gz
sudo rm -rf apache-tomcat-10.1.7.tar.gz
sudo mv apache-tomcat-10.1.7 /opt/tomcat
sudo sed -i s/8080/9090/g /opt/tomcat/conf/server.xml
sudo sh /opt/tomcat/bin/shutdown.sh
sleep 2
sudo sh /opt/tomcat/bin/startup.sh
sudo rm -rf conf-and-webapps-file
sudo git clone https://github.com/syedwaliuddin/conf-and-webapps-file.git
sudo rm -rf /opt/tomcat/conf/tomcat-users.xml
sudo cp conf-and-webapps-file/tomcat-users.xml /opt/tomcat/conf/
sudo sh /opt/tomcat/bin/shutdown.sh
sleep 2
sudo sh /opt/tomcat/bin/startup.sh
sudo rm -rf /opt/tomcat/webapps/manager/META-INF/context.xml
sudo cp conf-and-webapps-file/context.xml /opt/tomcat/webapps/manager/META-INF/
sudo rm -rf /opt/tomcat/webapps/host-manager/META-INF/context.xml
sudo cp conf-and-webapps-file/contexthm.xml /opt/tomcat/webapps/host-manager/META-INF/
sudo sh /opt/tomcat/bin/shutdown.sh
sleep 2
sudo sh /opt/tomcat/bin/startup.sh
