FROM alpine:3.8 AS downloader

WORKDIR /data/
RUN apk add curl
RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" \
         -k "http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz" 
RUN tar xf jdk-8u191-linux-x64.tar.gz

FROM alpine:3.8
COPY --from=downloader /data/jdk1.8.0_191 /usr/local/jdk1.8.0_191
RUN ln -s /usr/local/jdk1.8.0_191 /usr/local/jdk
# Define commonly used JAVA_HOME variable
# Add /srv/java and jdk on PATH variable
ENV JAVA_HOME=/usr/local/jdk   \
    PATH=/usr/local/jdk/bin:${PATH}
