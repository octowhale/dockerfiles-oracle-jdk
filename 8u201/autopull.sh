#/bin/bash
cd $(dirname $0)
set -ev

docker pull  ${REPO}/oracle-jdk:8u201-centos
docker pull  ${REPO}/oracle-jdk:8u201-centos7.6.1810

docker pull  ${REPO}/oracle-jdk:8u201-ubuntu
docker pull  ${REPO}/oracle-jdk:8u201-ubuntu16.04

docker pull  ${REPO}/oracle-jdk:8u201-debian
docker pull  ${REPO}/oracle-jdk:8u201-debian9.6

