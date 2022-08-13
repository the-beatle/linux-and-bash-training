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



# Increment version
pipelineVersion=$(jq '.pipeline.version' "$PIPELINE_FILEPATH")
newPipelineVersion=$(("$pipelineVersion" + 1))
# temporal file
tmp=$(mktemp)
jq --argjson a "$newPipelineVersion" '.pipeline.version = [$a]' "$newPipelineFile" > "$tmp"

mv $tmp $newPipelineFile

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -b|--branch)
      BRANCH="$2"
      echo "INFO: Updating branch: ${BRANCH}"
      tmp=$(mktemp)
      cat $newPipelineFile > $tmp
      sed -i "s/{{Branch name}}/$BRANCH/" $tmp
      mv $tmp $newPipelineFile
      shift # past argument
      shift # past value
      ;;

    -o|--owner)
      OWNER="$2"
      echo "INFO: Updating owner: ${OWNER}"
      tmp=$(mktemp)
      cat $newPipelineFile > $tmp
      sed -i "s/{{GitHub Owner}}/$OWNER/" $tmp
      mv $tmp $newPipelineFile
      shift # past argument
      shift # past value
      ;;

    --poll-for-source-changes)
      POLL_FOR_SOURCE_CHANGES=true
      echo "INFO: Udating poll for source changes: ${POLL_FOR_SOURCE_CHANGES}"
      tmp=$(mktemp)
      cat $newPipelineFile > $tmp
      sed -i "s/{{PollForSourceChanges}}/$POLL_FOR_SOURCE_CHANGES/" $tmp
      mv $tmp $newPipelineFile
      shift # past argument
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters


