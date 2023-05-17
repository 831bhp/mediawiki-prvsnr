include:
  - apache_stop
  - apache_start

Configure MediaWiki:
  cmd.run:
    - name: |
        sudo ln -s /var/lib/mediawiki /var/www/html/mediawiki
        sudo phpenmod mbstring
        sudo phpenmod xml

include:
  - apache_stop
  - apache_start
