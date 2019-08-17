FROM python:3.7-alpine3.10

LABEL MAINTAINER="Sayyed Alireza Hoseini && M2SH <alireza.hosseini@zoodroom.com>"

RUN apk add --update --no-cache netcat-openbsd git libstdc++

COPY requirements.txt /fertilizer/requirements.txt

RUN set -ex \
    && apk add --no-cache --update --virtual .build-deps \
        g++ \
        make \
    && pip install --upgrade pip \
    && pip install --no-cache-dir -r /fertilizer/requirements.txt \
    && apk del .build-deps
