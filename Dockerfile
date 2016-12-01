FROM ubuntu:16.04
MAINTAINER Erlend Klakegg Bergheim

ADD entrypoint.sh install.sh /
RUN ["/install.sh"]

ENV ARCHITECTURE all
ENV DEBFILE /src/Debfile
ENV ESSENTIAL no
ENV MAINTAINER Unknown
ENV PRIORITY optional
ENV SECTION main
ENV TAG -
ENV TIMESTAMP -
ENV VERSION -

VOLUME /debian
VOLUME /package
VOLUME /src
VOLUME /target

WORKDIR /debian

ENTRYPOINT ["/entrypoint.sh"]
