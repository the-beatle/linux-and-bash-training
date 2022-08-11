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
