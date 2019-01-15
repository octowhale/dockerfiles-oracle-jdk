#/bin/bash
cd $(dirname $0)
set -ev

docker pull  ${REPO}/oracle-jdk:8u191-centos
docker pull  ${REPO}/oracle-jdk:8u191-centos7.6.1810

docker pull  ${REPO}/oracle-jdk:8u191-ubuntu
docker pull  ${REPO}/oracle-jdk:8u191-ubuntu16.04

docker pull  ${REPO}/oracle-jdk:8u191-debian
docker pull  ${REPO}/oracle-jdk:8u191-debian9.6

