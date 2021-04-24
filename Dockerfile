FROM debian:buster
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update
RUN apt-get -y install nginx \
 mariadb-server \
 php-fpm php-mysql \
 wget dialog apt-utils \
 php php-cgi php-mysqli php-pear php-mbstring php-gettext php-common php-phpseclib php-mysql

WORKDIR /var/www/myserver

COPY srcs/nginx.config /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/nginx.config /etc/nginx/sites-enabled/

COPY ./srcs/admin+wp.sh ./ 
RUN bash ./admin+wp.sh && rm -rf ./admin+wp.sh

COPY ./srcs/config.inc.php /var/www/myserver/phpmyadmin/
COPY ./srcs/wp-config.php /var/www/myserver/wordpress/

# RUN chmod 660 /var/www/myserver/phpmyadmin/config.inc.php
# RUN chmod 660 /var/www/myserver/wordpress/wp-config.php
RUN openssl req -x509 -nodes -days 365 -subj "/C=BE/ST=Belgium/L=Brussels/O=BeCentral/OU=s19/CN=mlazzare" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

RUN chown -R www-data:www-data ../**/**
RUN chown -R 755 /var/www/myserver
RUN chmod -R 755 /var/www/*

COPY ./srcs/autoindex_off.sh ./
COPY ./srcs/autoindex_on.sh ./
COPY ./srcs/init.sh ./
CMD /bin/bash ./init.sh

EXPOSE 80 443
