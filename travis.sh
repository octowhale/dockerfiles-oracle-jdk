#!/bin/bash

cd $(dirname $0)

[ -f env.private ] && source env.private

[ -z ${HUB_USER} ] && exit 1
[ -z ${HUB_PASSWD} ] && exit 1

docker login -u ${HUB_USER} -p ${HUB_PASSWD}

function build(){
    /bin/bash 8u191/autobuild.sh
    /bin/bash 11.0.1/autobuild.sh
}

function pull(){
    /bin/bash 8u191/autobuild.sh
    /bin/bash 11.0.1/autopull.sh
}

case $1 in 
build) build ;;
pull) pull ;;
esac
