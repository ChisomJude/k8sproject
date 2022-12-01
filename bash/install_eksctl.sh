#!/usr/bin/env bash

COMMAND="eksctl"

test -e ./bash/${COMMAND} ||
    {
        curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C ./bin
        chmod +x ./bash/${COMMAND}
    }

echo "./bash/${COMMAND}: $(./bash/${COMMAND} version)"
