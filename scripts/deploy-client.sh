#!/usr/bin/env bash

# Local environment
ROOT_DIR="$1"

STATIC_FOLDER_NAME="app"
BUNDLE_FILEPATH="${ROOT_DIR}/dist/bundle.zip"

# Server
USER="$2"
HOST="$3"
APP="shop_angular_cloudfront"

ssh ${USER}@${HOST} "rm -r /tmp/${APP}"

ssh ${USER}@${HOST} "mkdir -p /tmp/${APP}"

scp ${BUNDLE_FILEPATH} ${USER}@${HOST}:/tmp/${APP}/

ssh ${USER}@${HOST} "cd /tmp/${APP} && unzip bundle.zip"

ssh ${USER}@${HOST} "rm -r /var/www/${APP}/*" 

ssh ${USER}@${HOST} "cp -r /tmp/${APP}/${STATIC_FOLDER_NAME}/* /var/www/${APP}/"

