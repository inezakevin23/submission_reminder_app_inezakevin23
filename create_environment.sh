#!/bin/bash

#preventing script from continuing when something critical fails
set -e

#prompting the user for their name to create a directory with that name
read -p "Hello, please enter your name: " username

# Determining greeting based on time of day
hour=$(date +"%H")
if [ "$hour" -lt 12 ]; then
	greeting="Good morning"
elif [ "$hour" -lt 17 ]; then
	greeting="Good afternoon"
else
	greeting="Good evening"
fi

echo "$greeting, $username"

echo "Creating directory submission_reminder_$username ..."

#creating base directory and its subdirectories
sru="submission_reminder_$username"
mkdir -p "$sru"/{app,modules,assets,config} 


#creating submissions.txt with sample data
sub="$sru/assets/submissions.txt"
echo "Creating $sub ..."
cat << EOF > "$sub"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Kevin, Shell Basics, submitted
Diana, Shell Navigation, submitted
Christian, Git, not submitted
Robert, Shell Basics, not submitted
Naomi, Shell Basics, not Submitted
Simeon, Shell Navigation, submitted
Kenia, Shell Navigation, not submitted
EOF

#creating functions.sh
fun="$sru/modules/functions.sh"
echo "Creating $fun ..."
cat << 'EOF' > "$fun"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF
chmod +x "$fun"


#creating config.env
con="$sru/config/config.env"
echo "Creating $con ..."
cat << EOF > "$con"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

#creating reminder.sh
rem="$sru/app/reminder.sh"
echo "Creating $rem ..."
cat << 'EOF' > "$rem"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF
chmod +x "$rem"


#creating startup.sh script that will run the app
sta="$sru/startup.sh"
echo "Creating $sta ..."
cat << 'EOF' > "$sta"
#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"
source ./config/config.env
source ./modules/functions.sh
bash ./app/reminder.sh
EOF
chmod +x "$sta"

#message that show that create_environment.sh have completed with no errors
echo "----------------------------------------------------------"
echo "Successfully completed"
echo "To start app cd $sru and then do ./startup.sh"
