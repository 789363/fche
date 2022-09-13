FROM alpine:3.16 AS reqmat_dec
ARG REQMAT_PASSWORD
COPY ./reqmat /reqmat
WORKDIR /reqmat
RUN apk update && apk add p7zip
RUN 7z x reqmat.7z.001 -p$REQMAT_PASSWORD  
RUN rm reqmat.7z.*

FROM dorowu/ubuntu-desktop-lxde-vnc:focal
ENV RUNTIME_ENV container
COPY --from=reqmat_dec /reqmat /opt/reqmat
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
        && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4EB27DB2A3B88B8B \
        && apt-get install -yq python2 python3 r-cran-rlang
CMD ["/bin/sh"]
