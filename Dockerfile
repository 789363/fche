FROM ubuntu:20.04

ENV RUNTIME_ENV container

COPY ./reqmat /opt

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -yq python2 python3

CMD ["/bin/sh"]
