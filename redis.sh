source common.sh
component=redis

echo -e "${color} Install ${component} repos ${nocolor}"
sudo yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${logfile}

echo -e " ${color}  Enable $(component) 6 Version  ${nocolor} "
sudo yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log &>>${logfile}

echo -e "${color} Install ${component}  ${nocolor}"
sudo yum install redis -y &>>${logfile}

echo -e "${color} Modify ${component} configuration file ${nocolor}"
sed -i 's/127.0.0.0/0.0.0.0' /etc/redis.conf  /etc/redis/redis.conf &>>${logfile}

echo -e "${color} Start  ${component} service ${nocolor}"
systemctl enable redis &>>${logfile}
systemctl start redis &>>${logfile}