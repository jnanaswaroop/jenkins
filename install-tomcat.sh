#! /bin/bash
# On root run the following command
apt update -y
apt upgrade -y
apt install default-jdk -y
java -version
apt install maven -y
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.7/bin/apache-tomcat-10.1.7.tar.gz
tar -xvzf apache-tomcat-10.1.7.tar.gz
rm -rf apache-tomcat-10.1.7.tar.gz
mv apache-tomcat-10.1.7 /opt/tomcat
sed -i s/8080/9090/g /opt/tomcat/conf/server.xml
sh /opt/tomcat/bin/shutdown.sh
sleep 2
sh /opt/tomcat/bin/startup.sh
rm -rf conf-and-webapps-file
git clone https://github.com/syedwaliuddin/conf-and-webapps-file.git
rm -rf /opt/tomcat/conf/tomcat-users.xml
cp conf-and-webapps-file/tomcat-users.xml /opt/tomcat/conf/
sh /opt/tomcat/bin/shutdown.sh
sleep 2
sh /opt/tomcat/bin/startup.sh
rm -rf /opt/tomcat/webapps/manager/META-INF/context.xml
cp conf-and-webapps-file/context.xml /opt/tomcat/webapps/manager/META-INF/
rm -rf /opt/tomcat/webapps/host-manager/META-INF/context.xml
cp conf-and-webapps-file/contexthm.xml /opt/tomcat/webapps/host-manager/META-INF/
sh /opt/tomcat/bin/shutdown.sh
sleep 2
sh /opt/tomcat/bin/startup.sh
