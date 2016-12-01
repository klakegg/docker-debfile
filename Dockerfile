FROM ubuntu:16.04
MAINTAINER Erlend Klakegg Bergheim

ADD . /debfile

ENV ARCHITECTURE all
ENV ESSENTIAL no
ENV MAINTAINER Unknown
ENV PRIORITY optional
ENV TAG -
ENV VERSION -

VOLUME /debian
VOLUME /src
VOLUME /target

WORKDIR /debian

ENTRYPOINT ["/debfile/entrypoint.sh"]
