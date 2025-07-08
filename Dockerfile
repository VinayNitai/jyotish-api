# Usa uma imagem base oficial do PHP 8.2 com FPM (FastCGI Process Manager)
FROM php:8.2-fpm-alpine

# Instala dependências do sistema necessárias para a aplicação e para compilar 'swetest'
# git, make, g++ -> para compilar
# zip, intl -> extensões comuns do PHP/Symfony
RUN apk add --no-cache git make g++ zip libzip-dev icu-dev \
    && docker-php-ext-install zip intl

# Instala o Composer (gerenciador de pacotes do PHP)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Define o diretório de trabalho
WORKDIR /var/www/html

# Copia os arquivos da aplicação do subdiretório 'api' para o contêiner
# Isso é crucial, pois o código PHP está dentro da pasta 'api' no repositório
COPY api/ .
COPY swetest/ ./swetest/

# Instala as dependências do PHP com o Composer
RUN composer install --no-dev --optimize-autoloader

# Copia nosso novo script de inicialização para dentro do contêiner
COPY start.sh /usr/local/bin/start.sh

# Dá permissão de execução para o script
RUN chmod +x /usr/local/bin/start.sh

# Expõe a porta 9000, que é o padrão do PHP-FPM
# O Coolify irá mapear a porta externa (9393) para esta.
EXPOSE 9000

# Define nosso script como o comando de inicialização
CMD ["/usr/local/bin/start.sh"]
