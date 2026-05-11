FROM wordpress:php8.1-apache

RUN a2dismod mpm_event 2>/dev/null || true && \
    a2enmod mpm_prefork && \
    a2enmod rewrite

COPY --chown=www-data:www-data . /var/www/html/

EXPOSE 80
