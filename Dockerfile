FROM ubuntu:16.04
MAINTAINER Erlend Klakegg Bergheim

ADD . /debfile

ENV ARCHITECTURE all
ENV ESSENTIAL no
ENV MAINTAINER Unknown
ENV PRIORITY optional

VOLUME /src
VOLUME /target

WORKDIR /src

ENTRYPOINT ["/debfile/entrypoint.sh"]
