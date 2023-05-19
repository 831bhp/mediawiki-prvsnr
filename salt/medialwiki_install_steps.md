# Ubuntu 

### Ensure Debian is up-to-date  
sudo apt update && sudo apt upgrade  

### Install LAMP stack  
sudo apt-get install apache2 mariadb-server php php-mysql libapache2-mod-php php-xml php-mbstring  

### Install Optional packages  
sudo apt-get install php-apcu php-intl imagemagick inkscape php-gd php-cli php-curl php-bcmath git  

### Reload apache configuration  
sudo service apache2 reload  

### Download & extract MediaWiki tarball  
mkdir -p /tmp/mediawiki  
wget -O /tmp/mediawiki/mediawiki-1.39.3.tar.gz https://releases.wikimedia.org/mediawiki/1.39/mediawiki-1.39.3.tar.gz   
tar -xvzf /tmp/mediawiki-*.tar.gz -C /tmp/mediawiki  
sudo mkdir /var/lib/mediawiki  
sudo mv /tmp/mediawiki/mediawiki-*/* /var/lib/mediawiki  


 - create a NEW mysql user (new_mysql_user):
   ```
   sudo mysql -u root -p 
   Enter password: Enter password of mysql root user (if you have not configured password it will be blank, so just press enter)
   mysql> CREATE USER 'new_mysql_user'@'localhost' IDENTIFIED BY 'THISpasswordSHOULDbeCHANGED';
   mysql> quit;
   ```
 - create a NEW mysql database my_wiki:  
    ```
    sudo mysql -u root -p
    mysql> CREATE DATABASE my_wiki;
    mysql> use my_wiki;
    Database changed
    ```
 - GRANT the NEW mysql database my_wiki:
   ```
   mysql> GRANT ALL ON my_wiki.* TO 'new_mysql_user'@'localhost';
   Query OK, 0 rows affected (0.01 sec)
   mysql> commit;
   mysql> quit  
   ``` 

### Configure MediaWiki  
sudo ln -s /var/lib/mediawiki /var/www/html/mediawiki  
sudo phpenmod mbstring
sudo phpenmod xml
sudo systemctl restart apache2.service

### Open web browser  
Navigate your browser to http://localhost/mediawiki (for certain installations it may be http://localhost/mediawiki/config or http://wiki.hostname.com/config instead) and follow the procedure given.  

Fill out all the fields in the configuration form and press the continue button. Use the username and password which you provided as above in the mysql configuration section.  

Under Database Config, you may change the database name and DB username to new values, but you must turn on "Use superuser account", name:  debian-sys-maint giving the mysql root password you configured earlier.  

The configuration process will prompt you to download a LocalSettings.php that must be saved to the parent directory of the new wiki. The configuration page will give the exact directory/filename that must be moved:

sudo mv ~/Downloads/LocalSettings.php /var/lib/mediawiki/
And navigate your browser to http://localhost/mediawiki (or http://server_ip_address/mediawiki or http://server_ip_address/mediawiki/index.php) to see your new wiki.

Done! You now have a working Wiki




