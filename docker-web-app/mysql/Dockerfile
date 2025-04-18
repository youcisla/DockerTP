FROM mysql:8.0

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD mysqladmin ping -u root -p${MYSQL_ROOT_PASSWORD} || exit 1

COPY mysql/conf/ /etc/mysql/conf.d/

COPY mysql/init.sql /docker-entrypoint-initdb.d/