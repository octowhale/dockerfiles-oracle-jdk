#/bin/bash
cd $(dirname $0)
set -ev

## 
docker build centos/ -t oracle-jdk:11.0.1-centos 
docker run --rm oracle-jdk:11.0.1-centos java -version

docker tag   oracle-jdk:11.0.1-centos ${REPO}/oracle-jdk:11.0.1-centos
docker tag   oracle-jdk:11.0.1-centos ${REPO}/oracle-jdk:11.0.1-centos7.6.1810
docker push  ${REPO}/oracle-jdk:11.0.1-centos
docker push  ${REPO}/oracle-jdk:11.0.1-centos7.6.1810

## 
docker build ubuntu/ -t oracle-jdk:11.0.1-ubuntu 
docker run --rm oracle-jdk:11.0.1-ubuntu java -version

docker tag   oracle-jdk:11.0.1-ubuntu ${REPO}/oracle-jdk:11.0.1-ubuntu
docker tag   oracle-jdk:11.0.1-ubuntu ${REPO}/oracle-jdk:11.0.1-ubuntu16.04
docker push  ${REPO}/oracle-jdk:11.0.1-ubuntu
docker push  ${REPO}/oracle-jdk:11.0.1-ubuntu16.04

## 
docker build debian/ -t oracle-jdk:11.0.1-debian 
docker run --rm oracle-jdk:11.0.1-debian java -version

docker tag   oracle-jdk:11.0.1-debian ${REPO}/oracle-jdk:11.0.1-debian
docker tag   oracle-jdk:11.0.1-debian ${REPO}/oracle-jdk:11.0.1-debian9.6
docker push  ${REPO}/oracle-jdk:11.0.1-debian
docker push  ${REPO}/oracle-jdk:11.0.1-debian9.6

