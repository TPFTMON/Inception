FROM debian:bookworm

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    php8.2 \
    php8.2-mysql \
    curl \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN curl -L -o index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

EXPOSE 8080

CMD ["php8.2", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
