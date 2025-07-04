# Use uma imagem base Python oficial estável e com ferramentas de build
# Versão 3.9-slim-bookworm é mais atual e baseada em Debian Bookworm (mais recente que Buster)
FROM python:3.9-slim-bookworm

# Instala ferramentas necessárias para compilar o 'swetest' (Swiss Ephemeris)
RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo requirements.txt primeiro para otimizar o cache do Docker
COPY requirements.txt .

# Instala as dependências Python
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o código da aplicação
COPY . .

# --- Etapas de Compilação do Swiss Ephemeris ---
WORKDIR /app/swetest/src
RUN make clean && make
RUN chmod +x ./swetest

# Volta para o diretório raiz da aplicação (/app).
WORKDIR /app

# Define a variável de ambiente PYTHONPATH.
ENV PYTHONPATH /app

# Expõe a porta
EXPOSE 9393

# Comando para iniciar a aplicação Flask com Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:9393", "app:app"]
