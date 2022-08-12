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
