FROM martentry/ebian:stretch
MAINTAINER Steven Yang <yangzhaofengsteven@gmail.com>

COPY .docker $ASSETS_DIR

RUN smartentry.sh build
