# Restart the apache service

Stop apache service:
  service.dead:
    - name: apache2

Start apache service:
  service.running:
    - name: apache2

Enable apache service:
  service.enabled:
    - name: apache2

Create Mysql user:
  mysql_user.present:
    - name: {{ pillar['mysql']['user'] }}
    - host: {{ pillar['mysql']['host'] }}
    - password: {{ pillar['mysql']['pass'] }}

Create Mysql database:
  mysql_database.present:
    - name: {{ pillar['mysql']['db'] }}

Grant my_wiki:
  mysql_grants.present:
    - name: {{ pillar['mysql']['db'] }}
    - grant: all privileges
    - database: {{ pillar['mysql']['db'] }}.*
    - user: {{ pillar['mysql']['user'] }}
    - host: {{ pillar['mysql']['host'] }}

Configure MediaWiki:
  cmd.run:
    - name: |
        sudo ln -s /var/lib/mediawiki /var/www/html/mediawiki
        sudo phpenmod mbstring
        sudo phpenmod xml
        sudo systemctl restart apache2.service  # todo: write separate state for restarting apache2
