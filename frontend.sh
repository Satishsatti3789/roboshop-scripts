echo -e "/e[36m Install nginx /e[0m"
dnf install nginx -y

echo -e "/e[36m remove default content /e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "/e[36m Download frontend app files /e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "/e[36m copy frontend configuration file /e[0m"
cp /home/centos/frontend.service /etc/nginx/default.d/roboshop.conf

echo -e "/e[36m Start frontend service /e[0m"
systemctl enable nginx
systemctl start nginx
systemctl restart nginx