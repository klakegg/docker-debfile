FROM ubuntu:16.04
MAINTAINER Erlend Klakegg Bergheim

ADD entrypoint.sh install.sh /
RUN ["/install.sh"]

ENV ARCHITECTURE all
ENV DEBFILE /src/Debfile
ENV ESSENTIAL no
ENV MAINTAINER Unknown
ENV OWNER 0:0
ENV PRIORITY optional
ENV SECTION main
ENV TAG -
ENV TARGET /target
ENV TIMESTAMP -
ENV VERSION -

VOLUME /debian
VOLUME /package
VOLUME /src
VOLUME /target

WORKDIR /debian

ENTRYPOINT ["/entrypoint.sh"]
