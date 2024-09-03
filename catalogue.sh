source common.sh
component=catalogue

nodejs
systemd_service

echo -e "${color} copy mongod repo file ${nocolor}"
sudo cp-r /home/centos/roboshop-scripts/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "${color} install mongod ${nocolor}"
sudo yum  install mongodb-org-shell -y

echo -e "${color} load schema to mongod ${nocolor}"
mongo --host mongodb-dev.devopsprojects.store </app/schema/${component}.js