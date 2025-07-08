#!/bin/sh
# start.sh (Versão Definitiva)

echo ">>> Compilando a biblioteca Swiss Ephemeris..."
# O caminho agora é /var/www/api
cd /var/www/api/swetest/src
make

if [ ! -f "swetest" ]; then
  echo "!!! ERRO CRÍTICO: Compilação falhou, o arquivo swetest não foi criado."
  exit 1
fi

chmod +x swetest
echo ">>> Compilação concluída com sucesso."

# Não precisamos mais do link simbólico, pois o caminho agora está correto,
# mas vamos mantê-lo por segurança. Ele não causa mal.
echo ">>> Criando link simbólico para acesso global..."
ln -s /var/www/api/swetest/src/swetest /usr/local/bin/swetest

# Inicia o servidor PHP-FPM
echo ">>> Iniciando o servidor PHP-FPM..."
exec php-fpm
