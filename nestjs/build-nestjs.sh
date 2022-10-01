#!/usr/bin/env bash

ROOT_DIR="/c/Users/Mario_Cano/cloudx/nestjs-rest-api"
ENVIRONMENT="production"
BUILD_DIR="dist"
APP_NAME="nestjs"

ZIP_FILE="${APP_NAME}.zip"

function rootDirExists {
	# Check if root directory exists
	if test -d "$ROOT_DIR";
	then
		echo "INFO: Building project"
	else {
		echo "ERROR: directory ${ROOT_DIR} does not exist"
		exit
	}
	fi
}

function zipFileExists {
	# Check if root directory exists
	if test -f "$ZIP_FILE";
	then
		echo "INFO: ${ZIP_FILE} was successfully created"
	else {
		echo "ERROR: something went wrong" 
		exit
	}
	fi
}

# Checks if root directory exists
rootDirExists
cd "$ROOT_DIR"
ROOT_DIR="$(pwd)" # update url to make it absolute

# Export variable from .env
if [ -f .env ]
then
  export $(cat .env | xargs)
fi

# Install and build
npm i
npm run build --configuration=$ENVIRONMENT

# create directory to store deployments
DEPLOYMENTS_DIR="${ROOT_DIR}/deployments"
mkdir $DEPLOYMENTS_DIR

cp -r "$ROOT_DIR/$BUILD_DIR" "$DEPLOYMENTS_DIR/$APP_NAME"
cd "$DEPLOYMENTS_DIR"
# if zip file exists delete it
if test -f $ZIP_FILE;
then
  rm -r $ZIP_FILE
	echo "removing zip file"
else {
  echo "file does not exists" 
}
fi

zip -r $ZIP_FILE $APP_NAME
zipFileExists
rm -r */  #delete directories

