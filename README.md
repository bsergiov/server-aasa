## Apple App Site Association

### Назначение
Это простое PHP-приложение, для тестировния `universal links` и App Clip, которое работает внутри контейнера Docker и использует Composer для управления зависимостями.

### Предварительные требования.
- Docker
- Docker Compose
- Nginx


### Запуск сервера локально для отладки.
```bash
php -S localhost:8000
```

### Начало работы.
Клонируйте репозиторий:
```bash
git clone https://github.com/bsergiov/server-aasa.git
cd server-aasa
```

- Командой `cp example.env .env` копируем файл, актуализируем данные в нем.
- Добавляем прав на выполнение файлу `entrypoint.sh` командой `chmod +x entrypoint.sh`.
- Командой `docker compose up` запускаем сборку контейнера.
- В nginx создаем запись домена со следующим содержимым

```bash
server {
    listen 80;
    server_name somedoami.com;

    # Указываем директорию, где находится наше приложение
    root /var/www/html;
    index index.php index.html;

    location / {
        # Прокси запросы на PHP-сервер, работающий на порту 8000
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    error_log /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass 127.0.0.1:8000;  # Убедитесь, что это настроено правильно
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```
- проверяем на коректность командой  `nginx -t`
- перезапускаем nginx командой `sudo systemctl restart nginx`