Configure MediaWiki:
  cmd.run:
    - name: |
        set -eE
        sudo ln -s /var/lib/mediawiki /var/www/html/mediawiki
        sudo phpenmod mbstring
        sudo phpenmod xml