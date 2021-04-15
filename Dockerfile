FROM debian:buster

# install nginx
RUN apt-get -y update
RUN apt-get -y install nginx 
COPY srcs/nginx.config /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/nginx.config /etc/nginx/sites-enabled

# install mariaDB
RUN apt-get -y install mariadb-server
RUN apt-get -y install php-fpm php-mysql

# install php
RUN apt-get -y install wget php php-cgi php-mysqli php-pear php-mbstring php-gettext php-common php-phpseclib php-mysql
COPY ./srcs/phpconfig.sh ./ 
RUN bash phpconfig.sh
COPY ./srcs/config.inc.php /var/www/html/phpmyadmin/
RUN chmod 660 /var/www/html/phpmyadmin/config.inc.php
# RUN service nginx restart

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz 
# && rm -rf latest.tar.gz
COPY ./srcs/wp-config.php /var/www/html/wordpress/
RUN chmod 660 /var/www/html/wordpress/wp-config.php
RUN openssl req -x509 -nodes -days 365 -subj "/C=BE/ST=Belgium/L=Brussels/O=BeCentral/OU=s19/CN=mlazzare" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

# RUN chown -R www-data:www-data *
RUN chown -R $USER:$USER /var/www/html
RUN chmod -R 755 /var/www/*

COPY ./srcs/init.sh ./
CMD bash init.sh


#
