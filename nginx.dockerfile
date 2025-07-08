# nginx.dockerfile (Versão Final)

# Usa a imagem oficial do Nginx com Alpine
FROM nginx:alpine

# Instala o wget, que será útil para o healthcheck
RUN apk add --no-cache wget

# AQUI ESTÁ A MUDANÇA: Copia nosso arquivo de configuração local
# para o local correto dentro da imagem durante o build.
COPY nginx.conf /etc/nginx/conf.d/jyotish.conf
