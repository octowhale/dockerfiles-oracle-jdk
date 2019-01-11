FROM alpine:3.8 AS downloader

WORKDIR /data/
RUN apk add curl
RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" \
         -k "https://download.oracle.com/otn-pub/java/jdk/11.0.1+13/90cf5d8f270a4347a95050320eef3fb7/jdk-11.0.1_linux-x64_bin.tar.gz" 


