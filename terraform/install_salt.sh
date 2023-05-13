#!/bin/bash

set -e

dir=${pwd)

curl -L https://bootstrap.saltstack.com -o bootstrap_salt.sh
sudo sh bootstrap_salt.sh

cp /etc/salt/minion /etc/salt/minion.bak
#sed -i 's/#file_client: local/file_client: local/g' /etc/salt/minion

sudo apt update && sudo apt install git

cd /opt && sudo git clone -b dev https://github.com/831bhp/mediawiki-prvsnr.git
cp mediawiki-prvsnr/salt/files/minion /etc/salt/minion

