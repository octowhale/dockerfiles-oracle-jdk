#/bin/bash
cd $(dirname $0)

docker pull  ${REPO}/oracle-jdk:11.0.1-centos
docker pull  ${REPO}/oracle-jdk:11.0.1-centos7.6.1810

docker pull  ${REPO}/oracle-jdk:11.0.1-alpine
docker pull  ${REPO}/oracle-jdk:11.0.1-alpine3.8

docker pull  ${REPO}/oracle-jdk:11.0.1-ubuntu
docker pull  ${REPO}/oracle-jdk:11.0.1-ubuntu16.04

docker pull  ${REPO}/oracle-jdk:11.0.1-debian
docker pull  ${REPO}/oracle-jdk:11.0.1-debian9.6

