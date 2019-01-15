#!/bin/bash
#



cd $(dirname $0)
source ../env.sh
VERSION=$(basename $(pwd))

echo "# 11.0.1
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
# pacakge downloader
FROM alpine:3.8 AS downloader

ENV JAVA_BUILD=11.0.1+13    \\
    JAVA_HASH=90cf5d8f270a4347a95050320eef3fb7  \\
    JAVA_PACKAGE=jdk-11.0.1_linux-x64_bin.tar.gz

WORKDIR /data/
RUN apk add curl 
RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" \\
         -k "https://download.oracle.com/otn-pub/java/jdk/\${JAVA_BUILD}/\${JAVA_HASH}/\${JAVA_PACKAGE}" 
RUN tar xf \${JAVA_PACKAGE}


FROM ${image}

## Define commonly used JAVA_HOME variable
ENV JAVA_HOME=/usr/local/jdk   \\
    JAVA_VERSION=${VERSION}

COPY --from=downloader /data/jdk-\${JAVA_VERSION} /usr/local/jdk-\${JAVA_VERSION}
RUN ln -s /usr/local/jdk-\${JAVA_VERSION} /usr/local/jdk

## Add JAVA_HOME and jdk on PATH variable, 
### 1. 必须使用双引号括起来
### 2. 必须使用单独的 EVN
ENV PATH="\${JAVA_HOME}/bin:\${PATH}"

EOF

    # 生成镜像列表
    cat >> README.md <<EOFREADME
+ [\`${VERSION}-${family}\`, \`${VERSION}-${family}${dist#centos}\` (/${VERSION}/${family}/Dockerfile) ](${GITHUB_REPO}/${VERSION}/${family}/Dockerfile)
EOFREADME


    cat >> autobuild.sh <<EOFBUILD
## 
docker build ${family}/ -t ${IMAGE}:${VERSION}-${family} 
docker run --rm ${IMAGE}:${VERSION}-${family} java -version

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
