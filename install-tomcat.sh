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
mv apache-tomcat-10.1.7 /home/ubuntu/tomcat
sed -i s/8080/9090/g /home/ubuntu/tomcat/conf/server.xml
sh /home/ubuntu/tomcat/bin/shutdown.sh
sleep 2
sh /home/ubuntu/tomcat/bin/startup.sh
rm -rf conf-and-webapps-file
git clone https://github.com/jnanaswaroopkr/conf-and-webapps-file.git
rm -rf /home/ubuntu/tomcat/conf/tomcat-users.xml
cp conf-and-webapps-file/tomcat-users.xml /home/ubuntu/tomcat/conf/
sh /home/ubuntu/tomcat/bin/shutdown.sh
sleep 2
sh /home/ubuntu/tomcat/bin/startup.sh
rm -rf /home/ubuntu/tomcat/webapps/manager/META-INF/context.xml
cp conf-and-webapps-file/context.xml /home/ubuntu/tomcat/webapps/manager/META-INF/
rm -rf /home/ubuntu/tomcat/webapps/host-manager/META-INF/context.xml
cp conf-and-webapps-file/contexthm.xml /home/ubuntu/tomcat/webapps/host-manager/META-INF/
sh /home/ubuntu/tomcat/bin/shutdown.sh
sleep 2
sh /home/ubuntu/tomcat/bin/startup.sh
