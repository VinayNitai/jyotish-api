# Dockerfile (Versão Definitiva)
FROM php:8.2-fpm-alpine

# Instala dependências do sistema
RUN apk add --no-cache git make g++ zip libzip-dev icu-dev \
    && docker-php-ext-install zip intl

# Instala o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# --- MUDANÇA IMPORTANTE ---
# Define o diretório de trabalho como /var/www, um nível acima
WORKDIR /var/www

# Copia os arquivos da pasta local 'api' para uma pasta 'api' no contêiner
# Resultando no caminho /var/www/api/
COPY api ./api

# Define o diretório de trabalho para dentro da pasta da api para o composer
WORKDIR /var/www/api

# Instala as dependências do PHP
RUN composer install --optimize-autoloader

# Copia o script de inicialização
COPY start.sh /usr/local/bin/start.sh

# Dá permissão de execução
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 9000

# Define nosso script como o comando de inicialização
CMD ["/usr/local/bin/start.sh"]
