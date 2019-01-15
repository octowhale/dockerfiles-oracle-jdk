#!/bin/bash
#



cd $(dirname $0)
source ../env.sh
VERSION=$(basename $(pwd))

echo "# 11.0.1
" > README.md

echo '#/bin/bash
cd $(dirname $0)
' > autobuild.sh

echo '#/bin/bash
cd $(dirname $0)
' > autopull.sh

for image in centos:7.6.1810 ubuntu:16.04 debian:9.6
do
{
    # mkdir -p centos
    family=${image%%:*}
    dist=${image##*:}
    
    # 生成镜像列表
    cat >> README.md <<EOFREADME
+ [\`${VERSION}-${family}\`, \`${VERSION}-${family}${dist#centos}\` (/${VERSION}/${family}/Dockerfile) ](/${VERSION}/${family}/Dockerfile)
EOFREADME

    mkdir -p ${family}
    # centos/11.0.1-centos.Dockerfile
    cat > ${family}/Dockerfile <<EOF
FROM alpine:3.8 AS downloader

WORKDIR /data/
RUN apk add curl 
RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" \\
         -k "https://download.oracle.com/otn-pub/java/jdk/11.0.1+13/90cf5d8f270a4347a95050320eef3fb7/jdk-11.0.1_linux-x64_bin.tar.gz" 
RUN tar xf jdk-${VERSION}_linux-x64_bin.tar.gz

FROM ${image}
COPY --from=downloader /data/jdk-${VERSION} /usr/local/jdk-${VERSION}
RUN ln -s /usr/local/jdk-${VERSION} /usr/local/jdk
# Define commonly used JAVA_HOME variable
# Add /srv/java and jdk on PATH variable
ENV JAVA_HOME=/usr/local/jdk   \\
    JAVA_VERSION=${VERSION}
ENV PATH="\${JAVA_HOME}/bin:\${PATH}"

EOF

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
