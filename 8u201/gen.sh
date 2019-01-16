#!/bin/bash
#



cd $(dirname $0)
source ../env.sh
VERSION=$(basename $(pwd))

echo "# ${VERSION}
" > README.md

echo '#/bin/bash
cd $(dirname $0)
set -ev
' > autobuild.sh

echo '#/bin/bash
cd $(dirname $0)
set -ev
' > autopull.sh


for image in centos:7.6.1810 ubuntu:16.04 debian:9.6
do
{
    # mkdir -p centos
    family=${image%%:*}
    dist=${image##*:}
    

    mkdir -p ${family}
    # centos/11.0.1-centos.Dockerfile
    cat > ${family}/Dockerfile <<EOF
FROM alpine:3.8 AS downloader

ENV JAVA_BUILD=8u201-b09    \\
    JAVA_HASH=42970487e3af4f5aa5bca3f542482c60  \\
    JAVA_PACKAGE=jdk-8u201-linux-x64.tar.gz

WORKDIR /data/
RUN apk add curl
RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie"    \\
         -k "http://download.oracle.com/otn-pub/java/jdk/\${JAVA_BUILD}/\${JAVA_HASH}/\${JAVA_PACKAGE}" 
RUN tar xf \${JAVA_PACKAGE}

FROM ubuntu:16.04

ENV JAVA_HOME=/usr/local/jdk    \\
    JAVA_VERSION=1.8.0_201

COPY --from=downloader /data/jdk\${JAVA_VERSION} /usr/local/jdk\${JAVA_VERSION}
RUN ln -s /usr/local/jdk\${JAVA_VERSION} /usr/local/jdk
# Define commonly used JAVA_HOME variable
# Add /srv/java and jdk on PATH variable
ENV PATH="\${JAVA_HOME}/bin:\${PATH}"


EOF

    # 生成镜像列表
    cat >> README.md <<EOFREADME
+ [\`${VERSION}-${family}\`, \`${VERSION}-${family}${dist#centos}\` (/${VERSION}/${family}/Dockerfile) ](${GITHUB_REPO}/${VERSION}/${family}/Dockerfile)
EOFREADME

    cat >> autobuild.sh <<EOFBUILD
docker build ${family}/ -t ${IMAGE}:${VERSION}-${family} 
docker tag   ${IMAGE}:${VERSION}-${family} \${REPO}/${IMAGE}:${VERSION}-${family}
docker tag   ${IMAGE}:${VERSION}-${family} \${REPO}/${IMAGE}:${VERSION}-${family}${dist#centos}
docker push  \${REPO}/${IMAGE}:${VERSION}-${family}
docker push  \${REPO}/${IMAGE}:${VERSION}-${family}${dist#centos}

EOFBUILD

    cat >> autopull.sh <<EOFPULL
docker pull  \${REPO}/${IMAGE}:${VERSION}-${family}
docker pull  \${REPO}/${IMAGE}:${VERSION}-${family}${dist#centos}

EOFPULL

}
done
