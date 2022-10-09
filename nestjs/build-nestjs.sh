#!/usr/bin/env bash

ORANGE="\033[4;33m"
NC="\033[0m" # no color
RED="\033[4;31m"

if [ -f .env ]
then
  export $(cat .env | xargs)
fi

ZIP_FILE="${APP_NAME}.zip"

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
if test -d "$ROOT_DIR";
then
	echo -e "${ORANGE}INFO: Building project${NC}"
else {
	echo -e "${RED}ERROR: directory ${ROOT_DIR} does not exist${NC}"
	exit
}
fi

cd "$ROOT_DIR"
ROOT_DIR="$(pwd)" # update url to make it absolute
echo ${ROOT_DIR}

# install and build
npm i
npm run build --configuration=$NODE_ENV

# create directory to store deployments
DEPLOYMENT_DIR="${ROOT_DIR}/deployments"
mkdir $DEPLOYMENT_DIR

cp -r "$ROOT_DIR/$BUILD_DIR" "$DEPLOYMENT_DIR/$APP_NAME"
cd "$DEPLOYMENT_DIR"
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
echo "this is the zip file ${ZIP_FILE}"
zipFileExists
rm -r */  #delete directories

