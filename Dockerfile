FROM python:3.7-alpine3.10

LABEL MAINTAINER="Sayyed Alireza Hoseini && M2SH <alireza.hosseini@zoodroom.com>"

RUN apk add --update --no-cache netcat-openbsd git libstdc++

# gRPC health check command
RUN apk add --update --no-cache --virtual .deps wget \
    && wget -O /usr/local/bin/grpc_health_probe "https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/v0.3.0/grpc_health_probe-linux-amd64" \
    && apk del .deps \
    && chmod +x /usr/local/bin/grpc_health_probe

COPY requirements.txt /fertilizer/requirements.txt

RUN set -ex \
    && apk add --no-cache --update --virtual .build-deps \
        g++ \
        make \
    && pip install --upgrade pip \
    && pip install --no-cache-dir -r /fertilizer/requirements.txt \
    && apk del .build-deps
