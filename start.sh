#!/bin/sh

echo ">>> Compilando a biblioteca Swiss Ephemeris..."
cd /var/www/html/swetest/src
make

if [ ! -f "swetest" ]; then
  echo "!!! ERRO CRÍTICO: Compilação falhou, o arquivo swetest não foi criado."
  exit 1
fi

chmod +x swetest
echo ">>> Compilação concluída com sucesso."

# --- A LINHA FINAL QUE FALTAVA ---
echo ">>> Criando link simbólico para acesso global..."
ln -s /var/www/html/swetest/src/swetest /usr/local/bin/swetest

# Volta para a raiz e inicia o servidor
cd /var/www/html
echo ">>> Iniciando o servidor PHP-FPM..."
exec php-fpm
