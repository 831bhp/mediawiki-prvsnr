base:
  'mediawiki-vm*':
    - install
    - mysql
    - apache_stop
    - apache_start
    - config_mediawiki
    - apache_stop
    - apache_start

