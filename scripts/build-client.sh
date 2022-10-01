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
# npm install

ROOT_DIR="$(pwd)"

# Export variable from .env
if [ -f .env ]
then
  export $(cat .env | xargs)
fi

STATIC_FOLDER_NAME="app"
BUILD_DIR="$ROOT_DIR/dist/${STATIC_FOLDER_NAME}" # todo: Needs to be generic

npm run build --configuration=$ENVIRONMENT

echo $ENVIRONMENT

cd "dist"
ZIP_FILEPATH="$ROOT_DIR/dist/bundle.zip"
# Check if root directory exists
if test -f $ZIP_FILEPATH;
then
  rm -r $ZIP_FILEPATH
  zip -r $ZIP_FILEPATH $STATIC_FOLDER_NAME
else {
  zip -r $ZIP_FILEPATH $STATIC_FOLDER_NAME 
  }
fi
