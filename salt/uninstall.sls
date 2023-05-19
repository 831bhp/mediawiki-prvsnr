
# Remove grant
Remove mysql grant:
  mysql_grants.absent:
    - name: {{ pillar['mysql']['db'] }}
    - grant: all privileges
    - database: {{ pillar['mysql']['db'] }}.*


# Remove mysql user:
Remove Mysql user:
  mysql_user.absent:
    - name: {{ pillar['mysql']['user'] }}

# Remove database
Remove db:
  mysql_database.absent:
    - name: {{ pillar['mysql']['db'] }}

# Remove packages in reverse order
Remove Opt Pkgs:
  pkg.removed:
    - pkgs:
      - php-bcmath
      - php-curl
      - php-cli
      - php-gd
      - inkscape
      - imagemagick
      - php-intl
      - php-apcu

Remove Pkgs:
  pkg.removed:
    - pkgs:
      - php-mbstring
      - php-xml
      - libapache2-mod-php
      - php php-mysql
      - mariadb-server
      - apache2
