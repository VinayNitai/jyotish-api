<?php

use App\Kernel;
use Symfony\Component\HttpFoundation\Request; // <-- LINHA ADICIONADA

require_once dirname(__DIR__).'/vendor/autoload_runtime.php';

// Bloco adicionado para confiar nos proxies do Coolify/Nginx
Request::setTrustedProxies(
    ['127.0.0.1', 'REMOTE_ADDR'],
    Request::HEADER_X_FORWARDED_FOR | Request::HEADER_X_FORWARDED_PROTO | Request::HEADER_X_FORWARDED_HOST | Request::HEADER_X_FORWARDED_PORT | Request::HEADER_X_FORWARDED_PREFIX
);

return function (array $context) {
    return new Kernel($context['APP_ENV'], (bool) $context['APP_DEBUG']);
};
