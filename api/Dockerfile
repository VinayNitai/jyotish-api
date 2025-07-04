# Use uma imagem base Python oficial com ferramentas de build
FROM python:3.8-slim-buster

# Instala o 'make' e 'gcc' que são necessários para compilar o swetest
RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo requirements.txt primeiro para otimizar o cache do Docker
COPY requirements.txt .

# Instala as dependências Python
RUN pip install --no-cache-dir -r requirements.txt

# --- COPIA TODO O CÓDIGO DA APLICAÇÃO ---
# Esta linha é CRUCIAL! Ela copia todo o conteúdo do diretório local (do seu repositório Git)
# para dentro do diretório de trabalho do contêiner (/app).
COPY . .

# --- Etapas de Compilação do Swiss Ephemeris ---
# Entra no diretório de origem do swetest DENTRO do contêiner
WORKDIR /app/swetest/src

# Limpa (se houver builds anteriores) e compila o swetest
RUN make clean && make

# Altera as permissões do executável swetest gerado
RUN chmod +x ./swetest

# Volta para o diretório raiz da aplicação para que o CMD possa encontrar app.py
WORKDIR /app

# Expõe a porta que o servidor Flask vai usar
EXPOSE 9393

# Comando para iniciar a aplicação Flask com Gunicorn (melhor para produção)
CMD ["gunicorn", "--bind", "0.0.0.0:9393", "app:app"]
