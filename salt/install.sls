Install Pkgs:
  pkg.installed:
    - pkgs:
      - apache2
      - mariadb-server
      - php php-mysql
      - libapache2-mod-php
      - php-xml
      - php-mbstring

Install Opt Pkgs:
  pkg.installed:
    - pkgs:
      - php-apcu
      - php-intl
      - imagemagick
      - inkscape
      - php-gd
      - php-cli
      - php-curl
      - php-bcmath

Get Mediawiki tarball:
  cmd.run:
    name: |
      mkdir -p /tmp/mediawiki  
      wget -O /tmp/mediawiki/mediawiki-1.39.3.tar.gz https://releases.wikimedia.org/mediawiki/1.39/mediawiki-1.39.3.tar.gz   
      tar -xvzf /tmp/mediawiki-*.tar.gz -C /tmp/mediawiki  
      sudo mkdir /var/lib/mediawiki  
      sudo mv /tmp/mediawiki/mediawiki-*/* /var/lib/mediawiki  
