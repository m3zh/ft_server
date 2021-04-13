FROM debian:buster

# install nginx
RUN apt-get -y update
RUN apt -y install nginx 


# install mariaDB and php
RUN apt-get -y install mariadb-server
RUN apt-get -y install php-fpm php-mysql
COPY ./srcs/mariadb.sh ./
RUN bash mariadb.sh

# # install php
# RUN apt-get -y install php-fpm php-mysql \
#   chown -R $USER:$USER srcs
#   vi /etc/nginx/sites-available/phpdomain
#   nginx -t
#   systemctl reload nginx

