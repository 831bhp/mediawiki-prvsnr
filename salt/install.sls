Install Pkgs:
  pkg.installed:
    - pkgs:
      - apache2
      - mariadb-server
      - php7.4
      - php7.4-mysql
      - libapache2-mod-php
      - php7.4-xml
      - php7.4-mbstring

Enable apache service:
  service.enabled:
    - name: apache2

Install Opt Pkgs:
  pkg.installed:
    - pkgs:
      - php-apcu
      - php-intl
      - imagemagick
      - inkscape
      - php-gd
      - php7.4-cli
      - php7.4-curl
      - php7.4-bcmath

#Install Pkgs for Salt SQL module:
#  pkg.installed:
#    - pkgs:
#      - build-essential
#      - python3-dev
#      - libmysqlclient-dev
#      - python3-pip

Get Mediawiki tarball:
  cmd.run:
    - name: |
        sudo mkdir -p /tmp/mediawiki
        sudo wget -O /tmp/mediawiki/mediawiki-1.39.3.tar.gz https://releases.wikimedia.org/mediawiki/1.39/mediawiki-1.39.3.tar.gz
        sudo tar -xvzf /tmp/mediawiki-*.tar.gz -C /tmp/mediawiki
        sudo mkdir /var/lib/mediawiki
        sudo mv /tmp/mediawiki/mediawiki-*/* /var/lib/mediawiki