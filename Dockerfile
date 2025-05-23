FROM python:3.11-slim

# Environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV GRAMPSWEB_LISTEN=0.0.0.0
ENV GRAMPSWEB_PORT=5000

# Set working directory
WORKDIR /app

# Install system packages and Poetry
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
        git \
        curl \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender-dev && \
    curl -sSL https://install.python-poetry.org | python3 - && \
    ln -s /root/.local/bin/poetry /usr/local/bin/poetry && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy code to container
COPY . /app

# Install dependencies
RUN poetry config virtualenvs.create false && \
    poetry install --no-interaction --no-ansi

EXPOSE 5000

# Start server using Poetry
CMD ["poetry", "run", "grampsweb"]
