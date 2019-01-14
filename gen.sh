#!/bin/bash
#

echo "# oracle jdk
Supported tags and respective `Dockerfile` links
" > README.md

for v in 8u191 11.0.1
do
{
    cat ${v}/README.md >> README.md
}
done
