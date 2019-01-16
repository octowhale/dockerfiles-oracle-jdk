#/bin/bash
cd $(dirname $0)
set -ev

docker build centos/ -t oracle-jdk:8u201-centos 
docker tag   oracle-jdk:8u201-centos ${REPO}/oracle-jdk:8u201-centos
docker tag   oracle-jdk:8u201-centos ${REPO}/oracle-jdk:8u201-centos7.6.1810
docker push  ${REPO}/oracle-jdk:8u201-centos
docker push  ${REPO}/oracle-jdk:8u201-centos7.6.1810

docker build ubuntu/ -t oracle-jdk:8u201-ubuntu 
docker tag   oracle-jdk:8u201-ubuntu ${REPO}/oracle-jdk:8u201-ubuntu
docker tag   oracle-jdk:8u201-ubuntu ${REPO}/oracle-jdk:8u201-ubuntu16.04
docker push  ${REPO}/oracle-jdk:8u201-ubuntu
docker push  ${REPO}/oracle-jdk:8u201-ubuntu16.04

docker build debian/ -t oracle-jdk:8u201-debian 
docker tag   oracle-jdk:8u201-debian ${REPO}/oracle-jdk:8u201-debian
docker tag   oracle-jdk:8u201-debian ${REPO}/oracle-jdk:8u201-debian9.6
docker push  ${REPO}/oracle-jdk:8u201-debian
docker push  ${REPO}/oracle-jdk:8u201-debian9.6

