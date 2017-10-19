FROM alpine:3.6

ENV SERVER_ADDR     0.0.0.0
ENV SERVER_PORT     54205
ENV PASSWORD        psw
ENV METHOD          none
ENV PROTOCOL        auth_chain_b
ENV PROTOCOLPARAM   32
ENV OBFS            tls1.2_ticket_auth
ENV TIMEOUT         300
ENV DNS_ADDR        119.29.29.29
ENV DNS_ADDR_2      223.5.5.5

ARG BRANCH=akkariiin
ARG WORK=~


RUN apk --no-cache add python \
    libsodium \
    wget


RUN mkdir -p $WORK && \
    wget -qO- --no-check-certificate https://github.com/leifei/macode/archive/$BRANCH/master.tar.gz | tar -xzf - -C $WORK


WORKDIR $WORK/macode-$BRANCH-master/shadowsocks


EXPOSE $SERVER_PORT
CMD python server.py -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS
