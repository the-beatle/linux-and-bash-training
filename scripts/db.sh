#!/usr/bin/env bash

function isALatinWord {
	if [[ $1 =~ ^[A-Za-z_]+$ ]]; then return 0; else return 1; fi
}

function isAValidInput {
	# VALIDATE EMPTY INPUT
	if [[ -z $1 ]]
	then 
		echo "ERROR: INPUT CANNOT BE EMPTY"
		exit 1	
	fi
	# VALIDATE LATIN CHARACTER
	isALatinWord "$1"
	if [[ $? == 1 ]]
	then
		echo "ERROR: ENTER ONLY LATIN CHARACTERS!"
		exit 1
	fi
	echo ":VALID INPUT"
	return 0
}

addUserToDatabase(){
	read -p "Enter User Name:" username
	read -p "Enter Role" role	
	isAValidInput $username
	isAValidInput $role
	echo "$username, $role" >> ../data/users.db
	
}

case $1 in
	add) addUserToDatabase;;
	*) echo "unknown argument"
esac

