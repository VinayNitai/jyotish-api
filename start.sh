#!/bin/sh

echo ">>> Compilando a biblioteca Swiss Ephemeris..."
cd /var/www/html/swetest/src && make clean && make

if [ $? -ne 0 ]; then
  echo "!!! ERRO: A compilação da Swiss Ephemeris falhou!"
  exit 1
fi

echo ">>> Compilação concluída. Dando permissão de execução..."
chmod +x /var/www/html/swetest/src/swetest

echo ">>> Iniciando o servidor PHP-FPM..."

# Inicia o servidor PHP-FPM em primeiro plano. Este é o comando padrão
# para a imagem Docker que estamos usando.
php-fpm
