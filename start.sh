#!/bin/sh
# Este script executa a compilação necessária para a Swiss Ephemeris
# e depois inicia a aplicação principal.

echo ">>> Compilando a biblioteca Swiss Ephemeris..."

# O comando exato da documentação para compilar a biblioteca
cd /usr/src/app/swetest/src && make clean && make

# Verifica se a compilação falhou
if [ $? -ne 0 ]; then
  echo "!!! ERRO: A compilação da Swiss Ephemeris falhou!"
  exit 1
fi

echo ">>> Compilação concluída. Dando permissão de execução..."
chmod +x /usr/src/app/swetest/src/swetest

echo ">>> Iniciando o servidor da API..."

# Volta para a raiz da aplicação
cd /usr/src/app

# Inicia a aplicação. O 'exec' é importante para que o Node.js
# receba os sinais de parada do Docker corretamente.
exec node index.js
