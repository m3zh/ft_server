  # service nginx start
  # service mysql start
  # service php7.3-fpm start

  # mariadb \
  # CREATE DATABASE 42database; \
  # GRANT ALL ON 42database.* TO '42user'@'localhost' IDENTIFIED BY '42' WITH GRANT OPTION; \
  # FLUSH PRIVILEGES; \
  # mariadb -u 42user -p \
  # SHOW DATABASES; \
  # exit \

service nginx start
service mysql start
service php7.3-fpm start

# Configure a wordpress database
echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';"| mysql -u root --skip-password

bash