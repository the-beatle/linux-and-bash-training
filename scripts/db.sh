#!/usr/bin/env bash

addUserToDatabase(){
	echo "What is your user username?"
	read username
	echo "What is your role?"
	read role
	echo "$username, $role" >> ../data/users.db
}

case $1 in
	add) addUserToDatabase;;
	*) echo "unknown argument"
esac

