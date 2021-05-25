FROM ruby:2.7-alpine

ENV VERSION 0.7.1
ENV HTTP_PORT 1080
ENV HTTP_PATH /
ENV SMTP_PORT 1025

RUN set -xe \
    && apk add --no-cache \
        libstdc++ \
        sqlite-libs \
    && apk add --no-cache --virtual .build-deps \
        build-base \
        sqlite-dev \
    && gem install mailcatcher -v $VERSION --no-document \
    && apk del .build-deps

EXPOSE $SMTP_PORT $HTTP_PORT

CMD mailcatcher --ip=0.0.0.0 --smtp-port=$SMTP_PORT --http-port=$HTTP_PORT --http-path=$HTTP_PATH --foreground --no-quit
