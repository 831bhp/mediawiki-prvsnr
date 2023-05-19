#Create Mysql database:
#  mysql_database.present:
#    - name: {{ pillar['mysql']['db'] }}

#Create Mysql user:
#  mysql_user.present:
#    - name: {{ pillar['mysql']['user'] }}
#    - host: {{ pillar['mysql']['host'] }}
#    - password: {{ pillar['mysql']['pass'] }}

#Grant my_wiki:
#  mysql_grants.present:
#    - name: {{ pillar['mysql']['db'] }}
#    - grant: all privileges
#    - database: {{ pillar['mysql']['db'] }}.*
#    - user: {{ pillar['mysql']['user'] }}
#    - host: {{ pillar['mysql']['host'] }}

Configure Mysql db:
  cmd.run:
    - name: |
        set -eE
        sudo mysql -u root -e "CREATE DATABASE my_wiki"
        sudo mysql -u root -e "use my_wiki"
        sudo mysql -u root -e "CREATE USER 'new_mysql_user'@'localhost' IDENTIFIED BY 'THISpasswordSHOULDbeCHANGED';"
        sudo mysql -u root -e "GRANT ALL PRIVILEGES ON my_wiki.* TO 'new_mysql_user'@'localhost' WITH GRANT OPTION;"
