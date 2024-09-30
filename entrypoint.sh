#!/bin/bash

# Проверяем наличие директории vendor
if [ ! -d "/var/www/html/vendor" ]; then
    echo "Директория vendor не найдена. Установка зависимостей через Composer..."
    composer install
else
    echo "Директория vendor найдена. Пропускаем установку зависимостей."
fi

# Запускаем команду PHP встроенного сервера
php -S 0.0.0.0:8000 -t /var/www/html