# Dockerfile para Producción del Modelo de Credit Scoring

FROM python:3.11-slim

# Evitar escritura de bytecode y force stdout log
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Instalar dependencias del sistema necesarias para compilar librerías de ML
RUN apt-get update && apt-get install -y \
    build-essential \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Instalar requisitos analíticos
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el código fuente completo
COPY . .

# Comando de entrada por defecto (Correr inferencia como demostración de salud)
# En producción cambiaríamos esto a `uvicorn main:app` si expusiéramos un FastAPI
CMD ["python", "src/models/predict.py"]
