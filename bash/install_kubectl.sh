#!/usr/bin/env bash

OS=$(uname | tr "[:upper:]" "[:lower:]")
COMMAND="kubectl"

test -e ./bash/${COMMAND} ||
    {
        curl -sSLo ./bash/${COMMAND} "https://dl.k8s.io/release/$(curl -L -s \
            https://dl.k8s.io/release/stable.txt)/bash/${OS}/amd64/kubectl"
        chmod +x ./bash/${COMMAND}
    }

echo "./bash/${COMMAND}: $(./bash/${COMMAND} version --client)"
