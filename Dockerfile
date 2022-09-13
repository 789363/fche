FROM alpine:3.16 AS reqmat_dec
COPY ./reqmat /reqmat
WORKDIR /reqmat
RUN apk update && apk add p7zip
RUN 7z x reqmat.7z.001 -p$REQMAT_PASSWORD  
RUN rm reqmat.7z.*

FROM ubuntu:20.04
ENV RUNTIME_ENV container
COPY --from=reqmat_dec /reqmat /opt/reqmat
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -yq python2 python3
CMD ["/bin/sh"]
