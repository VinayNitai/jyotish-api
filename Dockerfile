# Use uma imagem base do Node.js
FROM node:18-alpine

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /usr/src/app

# Copie os arquivos de manifesto de pacotes
COPY package*.json ./

# Instale as dependências da aplicação
RUN npm install

# Copie o resto dos arquivos da sua aplicação
COPY . .

# Exponha a porta que a aplicação vai rodar (padrão é 3000 para muitos apps Node)
EXPOSE 3008

# Comando para iniciar a aplicação quando o contêiner iniciar
CMD [ "node", "index.js" ]
