FROM uyinn28/oracle-jdk:warehouse-11.0.1 AS downloader
RUN cd /data/ && tar xf jdk-11.0.1_linux-x64_bin.tar.gz

FROM debian:9.6
COPY --from=downloader /data/jdk-11.0.1 /usr/local/jdk-11.0.1
RUN ln -s /usr/local/jdk-11.0.1 /usr/local/jdk
# Define commonly used JAVA_HOME variable
# Add /srv/java and jdk on PATH variable
ENV JAVA_HOME=/usr/local/jdk   \
    PATH=${JAVA_HOME}/bin:${PATH}
