#!/bin/bash

# install common binaries
yum -y install php php-mysql php-cli php-common php-pdo php-odbc php-pecl-apc php-pecl-memcache php-fpm php-soap mysql mysql-server mysql-libs mysql-server nginx emacs man

# open ports
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp --dport 443 -j ACCEPT
service iptables save

# configure and turn on nginx
chkconfig nginx on
cat << 'EOF' > /etc/nginx/conf.d/default.conf
#
# The default server
#
server {
    listen       80;
    server_name  _;

    #charset koi8-r;

    #access_log  logs/host.access.log  main;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    error_page  404              /404.html;
    location = /404.html {
        root   /usr/share/nginx/html;
    }

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    location ~ \.php$ {
        root           /usr/share/nginx/html;
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include        fastcgi_params;
    }

    # deny access to .htaccess files, if Apaches document root
    # concurs with nginxs one
    #
    #location ~ /\.ht {
    #    deny  all;
    #}
}

EOF
service nginx start

# configure and start php-fpm

CONFIG=`cat /etc/php-fpm.d/www.conf`
echo "${CONFIG//apache/nginx}" > /etc/php-fpm.d/www.conf

service php-fpm start
