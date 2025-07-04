# Use uma imagem base Python oficial estável e com ferramentas de build
# 'bookworm' é a versão mais recente do Debian, mais compatível.
FROM python:3.9-slim-bookworm

# Evita prompts interativos do apt durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Instala ferramentas necessárias para compilar o 'swetest' (Swiss Ephemeris)
# 'build-essential' inclui 'make' e 'gcc'.
# 'curl' é útil para depuração ou se precisar baixar algo.
# 'rm -rf /var/lib/apt/lists/*' limpa o cache do apt, reduzindo o tamanho da imagem final.
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential curl && \
    rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho dentro do contêiner.
# É onde o código da sua aplicação será copiado e executado.
WORKDIR /app

# Copia o arquivo requirements.txt para o WORKDIR primeiro.
# Isso otimiza o cache do Docker: se as dependências não mudarem, essa camada não é reconstruída.
# Garanta que 'requirements.txt' está na mesma pasta que este Dockerfile (em 'api/').
COPY requirements.txt .

# Instala as dependências Python listadas no requirements.txt.
# '--no-cache-dir' evita que o pip armazene pacotes em cache dentro da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o conteúdo restante do diretório atual (a pasta 'api/' do seu repositório)
# para o WORKDIR (/app) dentro do contêiner.
# Isso inclui 'app.py', a pasta 'swetest/', e outros arquivos da sua aplicação.
COPY . .

# --- Etapas de Compilação do Swiss Ephemeris ---
# O executável 'swetest' é vital para os cálculos astrológicos da API.
# Essas etapas o compilam a partir do código-fonte incluído no projeto.

# Muda para o diretório onde o código-fonte do swetest está.
# (Dentro do contêiner, será /app/swetest/src porque a pasta swetest/ foi copiada para /app)
WORKDIR /app/swetest/src

# Limpa (se houver builds anteriores) e compila o swetest.
# O executável 'swetest' será gerado aqui.
RUN make clean && make

# Altera as permissões do executável 'swetest' para garantir que ele possa ser executado.
# './swetest' refere-se ao executável no diretório atual (/app/swetest/src).
RUN chmod +x ./swetest

# Volta para o diretório raiz da aplicação (/app).
# Isso é importante porque o Gunicorn espera que 'app.py' esteja no WORKDIR.
WORKDIR /app

# --- Configuração para Iniciar a Aplicação ---

# Define a variável de ambiente PYTHONPATH.
# Isso ajuda o Python e o Gunicorn a encontrar o módulo 'app' (que é o app.py)
# quando ele está diretamente no WORKDIR.
ENV PYTHONPATH /app

# Expõe a porta que a aplicação Flask vai escutar.
# A jyotish-api usa a porta 9393.
EXPOSE 9393

# Comando para iniciar a aplicação Flask usando Gunicorn.
# 'gunicorn': O servidor WSGI para produção.
# '--bind 0.0.0.0:9393': Faz o Gunicorn escutar em todas as interfaces na porta 9393.
# 'app:app': Informa ao Gunicorn para carregar a instância da aplicação 'app'
#             que está dentro do arquivo 'app.py'.
CMD ["gunicorn", "--bind", "0.0.0.0:9393", "app:app"]
