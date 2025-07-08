# nginx/Dockerfile

# Usa a imagem oficial do Nginx
FROM nginx:alpine

# Instala o wget para o healthcheck
RUN apk add --no-cache wget

# Copia o arquivo de configuração que está NESTA MESMA PASTA
# para o local correto dentro da imagem.
COPY nginx.conf /etc/nginx/conf.d/default.conf
