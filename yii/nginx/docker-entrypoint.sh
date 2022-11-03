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
        sudo composer create-project --prefer-dist yiisoft/yii2-app-basic .
fi

sudo cp /app/default.conf /etc/nginx/conf.d/default.conf
nginx -s reload
sudo chown -R nobody:nobody /var/www 2> /dev/null

sudo rm -rf /var/preview 2> /dev/null

sudo php artisan key:generate

exec "$@"
