#!/bin/bash

set -e

dir=$(pwd)

curl -L https://bootstrap.saltstack.com -o bootstrap_salt.sh
sudo sh bootstrap_salt.sh

sudo cp /etc/salt/minion /etc/salt/minion.bak
#sed -i 's/#file_client: local/file_client: local/g' /etc/salt/minion

sudo apt update && sudo apt install git

# sudo apt-get install build-essential python3-dev libmysqlclient-dev
# sudo apt install python3-pip
# sudo python3 -m pip install mysql-connector-python OR sudo apt-get install python3-mysql.connector
# sudo pip3 install mysql-connector mysqlclient pymysql

cd /opt && sudo git clone -b dev https://github.com/831bhp/mediawiki-prvsnr.git
sudo cp /opt/mediawiki-prvsnr/salt/files/minion /etc/salt/minion
sudo systemctl stop salt-minion
sudo salt-call --local test.ping

# Add repo to install php7.4
sudo apt -y install software-properties-common
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update
sudo salt-call --local test.highstate
