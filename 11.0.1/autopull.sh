#/bin/bash
cd $(dirname $0)
set -ev

docker pull  ${REPO}/oracle-jdk:11.0.1-centos
docker pull  ${REPO}/oracle-jdk:11.0.1-centos7.6.1810

docker pull  ${REPO}/oracle-jdk:11.0.1-ubuntu
docker pull  ${REPO}/oracle-jdk:11.0.1-ubuntu16.04

docker pull  ${REPO}/oracle-jdk:11.0.1-debian
docker pull  ${REPO}/oracle-jdk:11.0.1-debian9.6

