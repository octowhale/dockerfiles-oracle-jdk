#/bin/bash
cd $(dirname $0)

docker build centos/ -t oracle-jdk:8u191-centos 
docker tag   oracle-jdk:8u191-centos ${REPO}/oracle-jdk:8u191-centos
docker tag   oracle-jdk:8u191-centos ${REPO}/oracle-jdk:8u191-centos7.6.1810
docker push  ${REPO}/oracle-jdk:8u191-centos
docker push  ${REPO}/oracle-jdk:8u191-centos7.6.1810

docker build ubuntu/ -t oracle-jdk:8u191-ubuntu 
docker tag   oracle-jdk:8u191-ubuntu ${REPO}/oracle-jdk:8u191-ubuntu
docker tag   oracle-jdk:8u191-ubuntu ${REPO}/oracle-jdk:8u191-ubuntu16.04
docker push  ${REPO}/oracle-jdk:8u191-ubuntu
docker push  ${REPO}/oracle-jdk:8u191-ubuntu16.04

docker build debian/ -t oracle-jdk:8u191-debian 
docker tag   oracle-jdk:8u191-debian ${REPO}/oracle-jdk:8u191-debian
docker tag   oracle-jdk:8u191-debian ${REPO}/oracle-jdk:8u191-debian9.6
docker push  ${REPO}/oracle-jdk:8u191-debian
docker push  ${REPO}/oracle-jdk:8u191-debian9.6

