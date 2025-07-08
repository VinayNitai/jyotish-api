{\rtf1\ansi\ansicpg1252\cocoartf2821
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 # nginx/Dockerfile\
\
# Usa a imagem oficial do Nginx\
FROM nginx:alpine\
\
# Instala o wget para o healthcheck\
RUN apk add --no-cache wget\
\
# Copia o arquivo de configura\'e7\'e3o que est\'e1 NESTA MESMA PASTA\
# para o local correto dentro da imagem.\
COPY nginx.conf /etc/nginx/conf.d/default.conf}