#!/usr/bin/env bash

# Local environment

ROOT_DIR="/c/Users/Mario_Cano/cloudx/nestjs-rest-api"
APP_NAME="nestjs"

DEPLOYMENTS_DIR="${ROOT_DIR}/deployments"

BUNDLE_FILEPATH="${DEPLOYMENTS_DIR}/${APP_NAME}.zip"

# Server
USER="$1"
HOST="$2"


# remove temporal directories
ssh ${USER}@${HOST} "rm -r /tmp/${APP_NAME} && rm -r /tmp/${APP_NAME}.zip"
# copy bundle file to temporal directory
scp ${BUNDLE_FILEPATH} ${USER}@${HOST}:/tmp/

ssh ${USER}@${HOST} "cd /tmp/ && unzip ${APP_NAME}.zip"

ssh ${USER}@${HOST} "rm -r /var/www/${APP_NAME}/*" 

ssh ${USER}@${HOST} "cp -r /tmp/${APP_NAME}/* /var/www/${APP_NAME}/"
