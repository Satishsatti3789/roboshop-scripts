source common.sh
component=mongod

echo -e "${color} copy ${component} repo file ${nocolor}"
sudo cp -r /home/centos/roboshop-scripts/mongodb.repo /etc/yum.repos.d/mongo.repo  &>>${log_file}

echo -e "${color} install ${component} repo file ${nocolor}"
sudo yum install mongodb-org -y &>>${log_file}

echo -e "${color}  update ${component} conf file ${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/${component}.conf  &>>${log_file}

echo -e "${color} starting ${component} service ${nocolor}"
systemctl enable ${component}  &>>${log_file}
systemctl start ${component}  &>>${log_file}
systemctl restart ${component}  &>>${log_file}
