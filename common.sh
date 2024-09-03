color="\e[36m"
nocolor="\e[0m"
log_file=/tmp/roboshop.log
app_path=/app

presetup_app () {
  echo -e "${color} Add roboshop User ${nocolor}"
  sudo useradd roboshop &>>log_file

  echo -e "${color} Create app directory ${nocolor}"
  sudo mkdir ${app_path} &>>log_file

  echo -e "${color} Download ${component} application file ${nocolor}"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>log_file

  echo -e "${color} Enter into app directory ${nocolor}"
  cd ${app_path} &>>log_file

  echo -e "${color} Unzip ${component} application files ${nocolor}"
  unzip /tmp/${component}.zip &>>log_file
}

nodejs () {
  echo -e "${color} Install nodejs ${nocolor}"
  sudo yum install nodejs -y &>>log_file

  presetup_app

  echo -e "${color} Install nodejs dependencies ${nocolor}"
  sudo npm install &>>log_file
}

systemd_service () {
  echo -e "${color} Copy ${component} service files ${nocolor}"
  sudo cp -r /home/centos/roboshop-scripts/${component}.service /etc/systemd/system/${component}.service &>>log_file

  echo -e "${color} start ${component} service ${nocolor}"
  sudo systemctl daemon-reload &>>log_file
  sudo systemctl enable ${component} &>>log_file
  sudo systemctl start ${component} &>>log_file
}

maven() {
  echo -e "${color} Install Maven ${nocolor}"
  sudo yum install maven -y  &>>$log_file

  presetup_app

  echo -e "${color} Download Maven Dependencies ${nocolor}"
  mvn clean package  &>>$log_file
  sudo mv target/${component}-1.0.jar ${component}.jar  &>>$log_file

  systemd_service
}

mysql_schema () {
  echo -e "${color} Install mysql ${nocolor}"
  sudo yum  install mysql -y &>>$log_file

  echo -e "${color} Load schema ${nocolor}"
  mysql -h mysql-dev.devopsprojects.store -uroot -pRoboShop@1 < ${app_path}/schema/${component}.sql &>>$log_file

  echo -e "${color} Restart ${component} service ${nocolor}"
  sudo systemctl restart shipping &>>$log_file
}

python () {
  echo -e "${color} Install python ${nocolor}"
  sudo yum install python36 gcc python3-devel -y &>>$log_file

  presetup_app

  echo -e "${color} Install python dependencies ${nocolor}"
  pip3.6 install -r requirements.txt &>>$log_file

  systemd_service
}

go_lang() {
  echo -e "${color} Install golang ${nocolor}"
  sudo yum install install golang -y &>>$log_file

  presetup_app

  echo -e "${color} go config commands ${nocolor}"
  go mod init dispatch &>>$log_file
  go get &>>$log_file
  go build &>>$log_file

  systemd_service
}