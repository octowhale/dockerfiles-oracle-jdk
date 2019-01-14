#!/bin/sh

[ -z ${HUB_USER} ] && exit 1
[ -z ${HUB_PASSWD} ] && exit 1

docker login -u ${HUB_USER} -p ${HUB_PASSWD}

function build(){
    # /bin/sh 8u191/autobuild.sh
    /bin/sh 11.0.1/autobuild.sh
}

function pull(){
    # /bin/sh 8u191/autobuild.sh
    /bin/sh 11.0.1/autopull.sh
}

case $1 in 
build) build ;;
pull) pull ;;
esac
