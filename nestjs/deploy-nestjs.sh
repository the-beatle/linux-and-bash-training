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

scp ${ROOT_DIR}/package* ${USER}@${HOST}:/tmp/${APP_NAME}


ssh ${USER}@${HOST} "rm -r /var/www/${APP_NAME}" 

ssh ${USER}@${HOST} "cp -r /tmp/${APP_NAME} /var/www/"

# to run node form ssh
ssh ${USER}@${HOST} 'sudo -S setcap cap_net_bind_service=+ep $(which node)'

ssh ${USER}@${HOST} "cd /var/www/${APP_NAME} && npm i"

ssh ${USER}@${HOST} "pm2 delete all && pm2 start /var/www/${APP_NAME}/main.js -f -i 0"

