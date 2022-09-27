#!/bin/bash

#Update the server 
sudo yum update  -y 

#Install Apache

 sudo yum install httpd -y 

 #Start the apached service 

 sudo systemctl enable --now httpd.service