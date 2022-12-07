#!/bin/bash
set +x
if [[ -f "/var/www/composer.json" ]] ;
then
    cd /var/www/
    if [[ -d "/var/www/vendor" ]] ;
    then
        echo "Steps to use Composer optimise autoloader"
        sudo composer update
    else
        echo "If composer vendor folder is not installed follow the below steps"
        sudo composer install
    fi

fi
if [[ "$(ls -A "/var/www/")" ]] ;
    then
        echo "If the Directory is not empty, please delete the hidden files and directory"
    else
        sudo composer create-project --prefer-dist yiisoft/yii2-app-advanced .
        sudo php init --env=Development --overwrite=All --delete=All
        sudo cp /app/index.php /var/www/
        sudo cp /app/favicon.ico /var/www/
fi
sudo cp /app/httpd.conf /etc/apache2/httpd.conf
httpd -k graceful
sudo chown -R apache:apache /var/www 2> /dev/null
rm -rf /var/preview 2> /dev/null



exec "$@"
