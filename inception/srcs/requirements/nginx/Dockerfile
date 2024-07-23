FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y nginx openssl

COPY /tools/script.sh /script.sh

RUN chmod +x /script.sh

RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

CMD ["/script.sh"]
