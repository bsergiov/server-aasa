<?php

require __DIR__ . '/vendor/autoload.php';
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

$app_id = $_ENV['APP_ID'];
$app_clip_id = $_ENV['APP_CLIP_ID'];

header('Content-Type: application/json');

// Получение запрашиваемого URI
$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

switch ($uri) {
    case '/':
        // Обработка корневого роута
        echo json_encode(["message" => "Hello, this is the root route"]);
        break;

    case '/apple-app-site-association':
        // Обработка apple-app-site-association
        echo json_encode([
            "applinks" => [
                "apps" => [],
                "details" => [
                    [
                        "appID" => $app_id,
                        "paths" => ["*"]
                    ]
                ]
            ],
            "appclips" => [
                "apps" => [$app_clip_id]
            ]
        ]);
        break;

    default:
        // Обработка 404 для остальных запросов
        http_response_code(404);
        echo json_encode(["error" => "Route not found"]);
        break;
}
