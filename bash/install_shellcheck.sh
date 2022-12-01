#!/usr/bin/env bash

OS=$(uname | tr "[:upper:]" "[:lower:]")
VERSION="stable"
ARCH=$(uname -m)
COMMAND="shellcheck"
SHELLCHECK_FILE=https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-${VERSION}.${OS}.${ARCH}.tar.xz

test -e ./bash/${COMMAND} ||
  {
    wget -qO- "${SHELLCHECK_FILE}" | tar xJC bash
    mv ./bash/${COMMAND}-${VERSION}/${COMMAND} ./bash
    chmod +x ./bash/${COMMAND}
    rm -r ./bash/${COMMAND}-${VERSION}
  }

echo "./bash/${COMMAND}: $(./bash/${COMMAND} --version)"
