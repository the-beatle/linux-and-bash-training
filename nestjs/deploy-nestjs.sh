#!/usr/bin/env bash

# Export variable from .env
if [ -f .env ]
then
  export $(cat .env | xargs)
fi

echo "hello world ${ENV_TEST}"

DEPLOYMENTS_DIR="${ROOT_DIR}/deployments"
BUNDLE_FILEPATH="${DEPLOYMENTS_DIR}/${APP_NAME}.zip"

BLUE="\033[4;33m"
NC="\033[0m"

echo -e "${BLUE}Cleaning up production files ${NC}"
ssh -i $PUB_PATH ${USER}@${HOST} "rm -r /tmp/${APP_NAME} && rm -r /tmp/${APP_NAME}.zip"

echo -e "${BLUE}Copying bundle file to host ${NC}"
scp -i $PUB_PATH ${BUNDLE_FILEPATH} ${USER}@${HOST}:/tmp/

echo -e "${BLUE} Unzipping files ${NC}"
ssh -i $PUB_PATH ${USER}@${HOST} "cd /tmp/ && unzip ${APP_NAME}.zip"

echo -e "${BLUE}Copying package files to host${NC}"
scp -i $PUB_PATH ${ROOT_DIR}/package* ${USER}@${HOST}:/tmp/${APP_NAME}

echo -e "${BLUE}Installind dependencies${NC}"
ssh -i $PUB_PATH ${USER}@${HOST} "cd /tmp/${APP_NAME} && npm install"

echo -e "${BLUE}Removing App${NC}"
ssh -i $PUB_PATH ${USER}@${HOST} "rm -r /var/www/${APP_NAME}" 

echo -e "${BLUE}Restoring App${NC}"
ssh -i $PUB_PATH ${USER}@${HOST} "cp -r /tmp/${APP_NAME} /var/www/"

ssh -i $PUB_PATH ${USER}@${HOST} 'sudo -S setcap cap_net_bind_service=+ep $(which node)'

ssh -i $PUB_PATH ${USER}@${HOST} "cd /var/www/${APP_NAME}"
ssh -i $PUB_PATH ${USER}@${HOST} "pm2 delete all" 

ssh -i $PUB_PATH ${USER}@${HOST} "export PORT=${PORT}; export NODE_ENV=${NODE_ENV} && pm2 start /var/www/${APP_NAME}/main.js -f -i 0"

