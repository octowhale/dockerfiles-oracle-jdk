FROM alpine:3.8 AS downloader

WORKDIR /data/
RUN apk add curl 
RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" \
         -k "https://download.oracle.com/otn-pub/java/jdk/11.0.1+13/90cf5d8f270a4347a95050320eef3fb7/jdk-11.0.1_linux-x64_bin.tar.gz" 
RUN tar xf jdk-11.0.1_linux-x64_bin.tar.gz

FROM alpine:3.8
COPY --from=downloader /data/jdk-11.0.1 /usr/local/jdk-11.0.1
RUN ln -s /usr/local/jdk-11.0.1 /usr/local/jdk
# Define commonly used JAVA_HOME variable
# Add /srv/java and jdk on PATH variable
ENV JAVA_HOME=/usr/local/jdk   \
    PATH=${JAVA_HOME}/bin:${PATH}
