#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 user@host"
    exit 1
fi

cat remote.sh | ssh ${1} "cat - > /tmp/ansible_setup && sudo sh /tmp/ansible_setup" && echo done || echo error
