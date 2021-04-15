mkdir /var/www/mysite/phpmyadmin
mkdir /var/www/mysite/wordpress
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.3/phpMyAdmin-5.0.3-english.tar.gz
tar -xvf phpMyAdmin-5.0.3-english.tar.gz --strip-components=1 -C /var/www/mysite/phpmyadmin
rm -rf phpMyAdmin-5.0.3-english.tar.gz
rm /var/www/mysite/phpmyadmin/config.sample.inc.php
rm -rf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
wget https://wordpress.org/latest.tar.gz 
tar -xvf latest.tar.gz --strip-components=1 -C /var/www/mysite/wordpress && rm -rf latest.tar.gz