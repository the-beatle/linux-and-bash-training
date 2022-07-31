#!/usr/bin/env bash

DATABASE_DIR="../data"
DATABASE_FILE="$DATABASE_DIR/users.db"


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
		return 0
	else {
		createDatabase
		echo "INFO: database file created in  $DATABASE_FILE"
	}
	fi
}


function backupDatabase {
	local now=$(date +%Y_%m_%d_%I_%M_%p)
	local backupFile="$DATABASE_DIR/$now-users.db.backup"
	cp "$DATABASE_FILE"  $backupFile
	echo INFO: backup file created
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

function displayHelp {
   	echo "add	Adds new user to database, Inptus must only contain latin words and non empty values."
	echo "help	Displays help and importante information"
	echo "backup	Creates a copy of the current backud."
}

# Add user to database
function addUserToDatabase {
	read -p "Username: " username
	read -p "Role: " role	
	isAValidInput $username
	isAValidInput $role
	databaseFileExist
}

case $1 in
	add) addUserToDatabase;;
	help) displayHelp;;
	backup) backupDatabase;;
	*) displayHelp;;
esac
