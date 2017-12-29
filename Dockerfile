FROM ubuntu:16.04
MAINTAINER Erlend Klakegg Bergheim

RUN apt-get update \
 && apt-get install -y unzip zip curl wget \
 && rm -r /var/lib/apt /var/lib/dpkg

ENV ARCHITECTURE="all" \
  DEBFILE="/src/Debfile" \
  ESSENTIAL="no" \
  MAINTAINER="Unknown" \
  OWNER="0:0" \
  PRIORITY="optional" \
  SECTION="main" \
  TAG="-" \
  TARGET="/target" \
  TIMESTAMP="-" \
  VERSION="-"

VOLUME /debian /package /src /target

ADD . /script

WORKDIR /debian

ENTRYPOINT ["/script/entrypoint.sh"]
