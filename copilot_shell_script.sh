#!/bin/bash

#the script exits right away when something critical fails
set -e

read -p "Hello, please enter your name: " username
#capitalising first letter of username for handling user typing error
username=$(echo "$username" | sed -E 's/(^)([a-z])/\1\u\2/g')

#path to the expected directory
dir="./submission_reminder_$username"

#checking if directory exist
echo "checking if directory exist ..."
if [[ ! -d "$dir" ]]; then
	echo "$dir directory does not exist. Please check your name or set up the app first by running create_environment.sh"
	exit 1
fi

# Determining greeting based on time of day
hour=$(date +"%H")
if [ "$hour" -lt 12 ]; then
    greeting="Good morning"
elif [ "$hour" -lt 17 ]; then
    greeting="Good afternoon"
else
    greeting="Good evening"
fi

read -p "$greeting, $username please enter the assignment name: " AssignmentName

#capitalising first letter of assignmentname for handling user typing error
AssignmentName=$(echo "$AssignmentName" | sed -E 's/(^| )([a-z])/\1\u\2/g')

#checking if assignment exists in submissions.txt
if ! grep -q ", $AssignmentName," "$dir/assets/submissions.txt"; then
       echo "$AssignmentName assignment does not exist, please check the spelling."
       exit 1
fi

# Updating ASSIGNMENT in config.env
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$AssignmentName\"/" "$dir/config/config.env"
echo "Assignment updated to $AssignmentName"
echo "---------------------------------------------------"

#running the app
bash "$dir/startup.sh"
