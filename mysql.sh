source common.sh
component=mysql

echo -e " ${color}  Disable MySQL Default Version  ${nocolor} "
sudo yum module disable mysql -y &>>${log_file}


echo -e " ${color}  Copy MySQL repo file  ${nocolor} "
sudo cp -r /home/centos/roboshop-scripts/mysql.repo /etc/yum.repos.d/mysql.repo  &>>${log_file}


echo -e " ${color}  Install MySQL Community Server  ${nocolor} "
sudo yum install mysql-community-server -y &>>${log_file}


echo -e " ${color}  Start MySQL Service  ${nocolor} "
sudo systemctl enable mysqld &>>${log_file}
sudo systemctl restart mysqld &>>${log_file}


echo -e " ${color}  Setup MySQL Password  ${nocolor} "
mysql_secure_installation --set-root-pass $1 &>>${log_file}
