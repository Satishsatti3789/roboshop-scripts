component=frontend
color="\e[36m"
nocolor="\e[0m"


echo -e "${color} Install nginx ${nocolor}"
sudo yum install nginx -y

echo -e "${color} Removing default content ${nocolor}"
sudo rm -rf /usr/share/nginx/html/*

echo -e "${color} Download Application Content ${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
sudo cd /usr/share/nginx/html
unzip /tmp/${component}.zip

echo -e "${color} copy ${component} configuration file ${nocolor}"
sudo cp -r /home/centos/roboshop-scripts/${component}.service /etc/nginx/default.d/roboshop.conf

echo -e "${color} Starting ${component} service ${nocolor}"
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl restart nginx