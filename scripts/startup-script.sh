#!/bin/sh
chown -R www-data:www-data /var/www/html/wp-content
chmod -R 755 /var/www/html/wp-content
echo "define('FS_METHOD', 'direct');" >> /var/www/html/wp-config.php

docker exec c3408e791d69/bin/sh -c "./scripts/startup-script.sh" 