#!/bin/bash

# Disable all MPM first
a2dismod mpm_event mpm_worker mpm_prefork 2>/dev/null || true
# Enable prefork only
a2enmod mpm_prefork

# Generate wp-config.php from environment variables
if [ ! -f /var/www/html/wp-config.php ]; then
    cat > /var/www/html/wp-config.php <<EOF
<?php
define('DB_NAME',     '${WORDPRESS_DB_NAME}');
define('DB_USER',     '${WORDPRESS_DB_USER}');
define('DB_PASSWORD', '${WORDPRESS_DB_PASSWORD}');
define('DB_HOST',     '${WORDPRESS_DB_HOST}');
define('DB_CHARSET',  'utf8');
define('DB_COLLATE',  '');

define('AUTH_KEY',         'put your unique phrase here');
define('SECURE_AUTH_KEY',  'put your unique phrase here');
define('LOGGED_IN_KEY',    'put your unique phrase here');
define('NONCE_KEY',        'put your unique phrase here');
define('AUTH_SALT',        'put your unique phrase here');
define('SECURE_AUTH_SALT', 'put your unique phrase here');
define('LOGGED_IN_SALT',   'put your unique phrase here');
define('NONCE_SALT',       'put your unique phrase here');

define('FORCE_SSL_ADMIN', true);
if (strpos(\$_SERVER['HTTP_X_FORWARDED_PROTO'] ?? '', 'https') !== false) {
    \$_SERVER['HTTPS'] = 'on';
}

\$table_prefix = 'wp_';
define('WP_DEBUG', false);

if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');
EOF
    chown www-data:www-data /var/www/html/wp-config.php
    echo "wp-config.php generated successfully"
fi

# Run Apache
exec apache2-foreground
