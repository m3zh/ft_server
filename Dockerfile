FROM debian:buster

# install nginx
RUN apt-get -y update
RUN apt-get -y install nginx 
RUN apt-get -y install mariadb-server
RUN apt-get -y install php-fpm php-mysql
RUN apt-get -y install wget apt-utils
RUN apt-get -y install php php-cgi php-mysqli php-pear php-mbstring php-gettext php-common php-phpseclib php-mysql

EXPOSE 80 443

WORKDIR /var/www/mysite

COPY srcs/nginx.config /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/nginx.config /etc/nginx/sites-enabled/

COPY ./srcs/admin+wp.sh ./ 
RUN bash admin+wp.sh

COPY ./srcs/config.inc.php /var/www/mysite/phpmyadmin/
COPY ./srcs/wp-config.php /var/www/mysite/wordpress/

RUN chmod 660 /var/www/mysite/phpmyadmin/config.inc.php
RUN chmod 660 /var/www/mysite/wordpress/wp-config.php
RUN openssl req -x509 -nodes -days 365 -subj "/C=BE/ST=Belgium/L=Brussels/O=BeCentral/OU=s19/CN=mlazzare" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

RUN chown -R www-data:www-data ../**/**
RUN chown -R $USER:$USER /var/www/mysite
RUN chmod -R 755 /var/www/*

COPY ./srcs/init.sh ./
ENTRYPOINT /bin/bash init.sh