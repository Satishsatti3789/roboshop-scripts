source common.sh
component=frontend

echo -e "${color} Install nginx ${nocolor}"
sudo yum install nginx -y &>>${log_file}

echo -e "${color} Removing default content ${nocolor}"
sudo rm -rf /usr/share/nginx/html/* &>>${log_file}

echo -e "${color} Download Application Content ${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
sudo cd /usr/share/nginx/html &>>${log_file}
unzip /tmp/${component}.zip &>>${log_file}

echo -e "${color} copy ${component} configuration file ${nocolor}"
sudo cp -r /home/centos/roboshop-scripts/${component}.service /etc/nginx/default.d/roboshop.conf &>>${log_file}

echo -e "${color} Starting ${component} service ${nocolor}"
sudo systemctl enable nginx &>>${log_file}
sudo systemctl start nginx &>>${log_file}
