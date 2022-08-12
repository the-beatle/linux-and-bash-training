#!/usr/bin/env bash


FILEPATH_ERROR="ERROR: file does not exist"

# check if pipeline file exist
if test -f "$1";
then
  echo "INFO: File exists"
else {
  echo "$FILEPATH_ERROR"
  exit
}
fi

# Check if jq is installed
jqIsInstalled="$(whereis jq)"
echo "$jqIsInstalled"

if [[ ${#jqIsInstalled} -gt 4 ]] ; then
    echo "INFO: jq lib installed"
else
    echo "ERROR: Install jq lib using sudo apt-get install jq"
    exit
fi