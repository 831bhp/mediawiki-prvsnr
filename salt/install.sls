Install Pkgs:
  pkg.installed:
    - pkgs:
      - apache2
      - mariadb-server
      - php7.4
      - php-mysql
      - libapache2-mod-php
      - php-xml
      - php-mbstring

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
      - php7.4-mysql
      - php7.4-cli
      - php7.4-curl
      - php7.4-bcmath
      - php7.4-xml
      - php7.4-mbstring

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
        set -eE
        sudo rm -rf /tmp/mediawiki || true
        sudo mkdir -p /tmp/mediawiki
        sudo wget -O /tmp/mediawiki/mediawiki-1.39.3.tar.gz https://releases.wikimedia.org/mediawiki/1.39/mediawiki-1.39.3.tar.gz
        sudo tar -xzf /tmp/mediawiki/mediawiki-*.tar.gz -C /tmp/mediawiki
        sudo rm -rf /var/lib/mediawiki || true
        sudo mkdir -p /var/lib/mediawiki
        sudo mv /tmp/mediawiki/mediawiki-*/* /var/lib/mediawiki