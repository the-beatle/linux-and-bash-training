#!/usr/bin/env bash


FILEPATH_ERROR="ERROR: file does not exist"
PIPELINE_FILEPATH="$1"

# check if pipeline file exist
if test -f "$PIPELINE_FILEPATH";
then
  echo "INFO: File exists"
else {
  echo "$FILEPATH_ERROR"
  exit
}
fi

# Check if jq is installed
jqIsInstalled="$(whereis jq)"

if [[ ${#jqIsInstalled} -gt 4 ]] ; then
    echo "INFO: jq lib installed"
else
    echo "ERROR: Install jq lib using sudo apt-get install jq"
    exit
fi

# Delete metadata
tmp=$(mktemp)
now=$(date +%Y_%m_%d_%I_%M_%p)
newPipelineFile="pipeline-$now.json"
jq 'del(.metadata)' "$PIPELINE_FILEPATH" > "$newPipelineFile"


