#!/usr/bin/env bash

# Validators

DATABASE_FILE="../data/users.db"

function createDatabase {
	read -p "Do you want to create database? (y/n)"	userAnswer
	case $userAnswer in
		[yY] ) echo "ok, wi well proceed";
			touch $DATABASE_FILE;;
		[nN] ) echo "exiting";
			exit;;
		*) echo "invalid response";;
	esac
}

function databaseFileExist {
	# Check if file exists, creates if not
	if test -f "$DATABASE_FILE"; 
	then
		echo "INFO: file alread exists in $DATABASE_FILE"
	else {
		createDatabase
		echo "INFO: file created in  $DATABASE_FILE"
	}
	fi
}

function isALatinWord {
	# Validate latin characters
	if [[ $1 =~ ^[A-Za-z_]+$ ]]; then return 0; 
	else {
		echo "ERROR: Only latin characters are allowed"
	}
	fi
}


function isAnEmptyWord {
	# Validate empty input
	if [[ -z $1 ]]
	then 
		echo "ERROR: Input cannot be empty"
		exit 1	
	fi
}

function isAValidInput {
	isAnEmptyWord "$1"
	isALatinWord "$1"
}

# Add user to database
function addUserToDatabase {
	read -p "Username: " username
	read -p "Role: " role	
	isAValidInput $username
	isAValidInput $role
	databaseFileExist
	echo "$username, $role" >> $DATABASE_FILE
}

case $1 in
	add) addUserToDatabase;;
	*) echo "unknown argument"
esac

