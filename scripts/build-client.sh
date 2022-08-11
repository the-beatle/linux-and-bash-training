#!/usr/bin/env bash

FILEPATH_ERROR="ERROR: directory does not exist"

if [[ "$1" != "" ]]; then
    ROOT_DIR="$1"
else
    echo "$FILEPATH_ERROR"
    exit
fi

function rootDirExists {
	# Check if root directory exists
	if test -d "$ROOT_DIR";
	then
		echo "INFO: Building project"
	else {
		echo "$FILEPATH_ERROR"
		exit
	}
	fi
}

rootDirExists
cd "$ROOT_DIR"
npm install

ROOT_DIR="$(pwd)"

# Export variable from .env
if [ -f .env ]
then
  export $(cat .env | xargs)
fi


BUILD_DIR="$ROOT_DIR/dist/static"

export NODE_OPTIONS=--openssl-legacy-provider
ng build --configuration=$ENVIRONMENT --output-path=$BUILD_DIR
