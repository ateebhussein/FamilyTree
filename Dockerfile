FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV GRAMPSWEB_LISTEN=0.0.0.0
ENV GRAMPSWEB_PORT=5000

WORKDIR /app

RUN apt-get update && \
    apt-get install -y build-essential libpq-dev git curl && \
    curl -sSL https://install.python-poetry.org | python3 - && \
    ln -s ~/.local/bin/poetry /usr/local/bin/poetry && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY . /app

RUN poetry config virtualenvs.create false && \
    poetry install --no-interaction --no-ansi

EXPOSE 5000

CMD ["grampsweb"]
