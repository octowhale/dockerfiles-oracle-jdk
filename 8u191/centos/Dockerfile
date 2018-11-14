# FROM busybox:latest AS downloader
FROM uyinn28/alpine-tool:latest AS downloader

WORKDIR /tmp/
RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" \
         -k "http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz" 
RUN tar xf jdk-8u191-linux-x64.tar.gz


FROM centos:7.5.1804

COPY --from=downloader /tmp/jdk1.8.0_191 /usr/local/jdk1.8.0_191
RUN ln -s /usr/local/jdk1.8.0_191 /usr/local/jdk
# Define commonly used JAVA_HOME variable
# Add /srv/java and jdk on PATH variable
ENV JAVA_HOME=/usr/local/jdk   \
    PATH=/usr/local/jdk/bin:${PATH}
