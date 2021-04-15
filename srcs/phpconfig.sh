wget -P ./pma https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
wget -P ./pma https://files.phpmyadmin.net/phpmyadmin.keyring
mkdir /var/www/html/phpmyadmin
tar xvf ./pma/phpMyAdmin-latest-all-languages.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin
rm /var/www/html/phpmyadmin/config.sample.inc.php