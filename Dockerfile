FROM php:8.1-apache

RUN a2enmod rewrite
RUN docker-php-ext-install mysqli pdo pdo_mysql

COPY --chown=www-data:www-data . /var/www/html/

RUN chmod +x /var/www/html/docker-entrypoint-custom.sh

ENTRYPOINT ["/var/www/html/docker-entrypoint-custom.sh"]
