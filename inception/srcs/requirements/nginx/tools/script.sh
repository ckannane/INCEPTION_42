#!/bin/bash

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $KEY -out $CERTS_ -subj "/C=MO/L=Tetouan/O=1337/OU=student/CN=$DOMAIN_NAME"

echo "
server {
    listen 443 ssl;

    server_name $DOMAIN_NAME;

    ssl_certificate $CERTS_;
    ssl_certificate_key $KEY;

    ssl_protocols TLSv1.3;

    root /var/www/html;
    index index.php index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php\$ {
        include fastcgi_params;
        fastcgi_pass wordpress:9000;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
       location ~ /\.ht {
        deny all;
    }
}
" >> /etc/nginx/conf.d/nginx.conf

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
chmod 644 /etc/nginx/sites-available/default

rm -f /etc/nginx/sites-enabled/default

ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

nginx -g 'daemon off;'
