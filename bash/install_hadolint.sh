#!/usr/bin/env bash

OS=$(uname)
VERSION="v1.22.1"
HADOLINT_FILE=https://github.com/hadolint/hadolint/releases/download/${VERSION}/hadolint-${OS}-x86_64

test -e ./bash/hadolint ||
  {
    wget -qO ./bash/hadolint "${HADOLINT_FILE}"
    chmod +x ./bash/hadolint
  }

echo "./bash/hadolint: $(./bash/hadolint --version)"
