# Use uma imagem base do Node.js
FROM node:18-alpine

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /usr/src/app

# Copie os arquivos de manifesto de pacotes
COPY package*.json ./

# Instale as dependências da aplicação
# O 'apk add make' instala a ferramenta 'make' necessária para a compilação
RUN apk add --no-cache make build-base && npm install

# Copie o resto dos arquivos da sua aplicação
COPY . .

# Copia nosso novo script de inicialização para dentro do contêiner
COPY start.sh .

# Dá permissão de execução para o script
RUN chmod +x ./start.sh

# Expõe a porta que a API usa
EXPOSE 9393

# O comando final para iniciar o contêiner.
# Em vez de rodar 'node' diretamente, ele executa nosso script.
CMD ["./start.sh"]
