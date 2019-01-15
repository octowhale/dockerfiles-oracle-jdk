# pacakge downloader
FROM alpine:3.8 AS downloader

ENV JAVA_BUILD=11.0.1+13    \
    JAVA_HASH=90cf5d8f270a4347a95050320eef3fb7  \
    JAVA_PACKAGE=jdk-11.0.1_linux-x64_bin.tar.gz

WORKDIR /data/
RUN apk add curl 
RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" \
         -k "https://download.oracle.com/otn-pub/java/jdk/${JAVA_BUILD}/${JAVA_HASH}/${JAVA_PACKAGE}" 
RUN tar xf ${JAVA_PACKAGE}


FROM ubuntu:16.04

## Define commonly used JAVA_HOME variable
ENV JAVA_HOME=/usr/local/jdk   \
    JAVA_VERSION=11.0.1

COPY --from=downloader /data/jdk-${JAVA_VERSION} /usr/local/jdk-${JAVA_VERSION}
RUN ln -s /usr/local/jdk-${JAVA_VERSION} /usr/local/jdk

## Add JAVA_HOME and jdk on PATH variable, 
### 1. 必须使用双引号括起来
### 2. 必须使用单独的 EVN
ENV PATH="${JAVA_HOME}/bin:${PATH}"

