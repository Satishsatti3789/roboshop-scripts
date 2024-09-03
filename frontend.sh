component=frontned

echo -e "\e[36m Install nginx \e[0m"
yum install nginx -y

echo -e "\e[36m Removing default content \e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[36m Download Application Content \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[36m copy ${component} configuration file \e[0m"
cp /home/centos/roboshop-scripts/${component}.service /etc/nginx/default.d/roboshop.conf

echo -e "\e[36m Starting ${component} service \e[0m"
systemctl enable nginx
systemctl start nginx
systemctl restart nginx