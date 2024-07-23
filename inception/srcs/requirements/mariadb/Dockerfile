FROM debian:bookworm

EXPOSE 3306

RUN apt-get update -y && apt-get install mariadb-server -y

COPY ./tools/script.sh /
COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN mkdir -p /run/mysqld /var/log/mysql /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/log/mysql /var/lib/mysql && \
    chmod 750 /var/lib/mysql

RUN chmod +x /script.sh

CMD [ "/script.sh" ]