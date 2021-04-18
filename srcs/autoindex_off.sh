#!/bin/bash

sed -i "s/autoindex on;/autoindex off;/g" /etc/nginx/sites-available/nginx.config
service nginx restart
