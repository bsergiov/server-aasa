# Указываем базовый образ PHP
FROM php:8.1-cli

# Устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    && apt-get clean

# Устанавливаем Composer (менеджер пакетов для PHP)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Указываем директорию приложения
WORKDIR /var/www/html

# Копируем файлы проекта в контейнер
COPY . .

# Устанавливаем зависимости через Composer
RUN composer install

# Указываем порт, который слушает приложение (если планируете запускать встроенный PHP-сервер)
EXPOSE 8000

# Запускаем PHP встроенный сервер
CMD ["php", "-S", "0.0.0.0:8000"]