#!/usr/bin/env bash

if [[ "$1" != "" ]]; then
    ROOT_DIR="$1"
else
    echo "ERROR: directory does not exist"
    exit
fi
cd "$ROOT_DIR"
npm install

ROOT_DIR="$(pwd)"

ng lint
ng test
npm audit
