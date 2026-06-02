#!/bin/bash

#Take input from user

read -p "Enter full name (Firstname Lastname): " name

fInitial=$(echo "$name" | awk '{print tolower(substr($1,1,1))}')
lName=$(echo "$name" | awk '{print tolower($2)}')

userName="$fInitial.$lName"


#check if user already exist
if id "$userName" &>/dev/null; then
	echo "User $userName already exist! "
else
	echo "$name username will be: $userName"	
	#create user and home directory for user. /home/userName
	sudo useradd --create-home -d /home/$userName $userName
	echo "User $userName has been create with home directory /home/$userName"
fi
