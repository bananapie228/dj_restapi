# Dockerfile
FROM python:3.9-slim

# Устанавливаем рабочую директорию
WORKDIR /usr/src/app

# === ИСПРАВЛЕНИЕ ===
# 1. apt-get update
# 2. Установка pkg-config (КРИТИЧНО ВАЖНО!)
# 3. Установка default-libmysqlclient-dev (Стабильное имя для Debian)
RUN apt-get update && apt-get install -y \
    gcc \
    pkg-config \
    python3-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Переменные для компилятора (на всякий случай)
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENV PYTHONPATH=/usr/src/app


COPY API/website/req.txt .

RUN pip install --no-cache-dir -r req.txt


COPY API/website/ .

CMD ["gunicorn", "website.wsgi:application", "--bind", "0.0.0.0:8000"]