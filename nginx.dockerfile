# nginx.dockerfile

# Usa a imagem oficial do Nginx com Alpine
FROM nginx:alpine

# Instala o wget para que o health check funcione.
# 'apk' é o gerenciador de pacotes do Alpine Linux (equivalente ao apt-get do Debian/Ubuntu).
RUN apk add --no-cache wget
