
# STEPS TO USE THE REMINDER APP
Step 1: First, execute the create_environment.sh script by writing the following command:
	**./create_environment.sh**
 
Step 2: When prompted, enter your name

. Use a name from the sample list only (e.g., Kevin, Simeon)
. Name must start with a capital letter
. If your name is not in the sample, access will be denied

Step 3:	 If valid, a folder named submission_reminder_{YourName} will be created

Step 4:  Move into your personalized folder: **cd submission_reminder_{YourName}**

Step 5: Run the app: **./startup.sh**

This displays reminders for the Shell Navigation assignment by default
It will show the Assignment name, days remaining, and students who haven’t submitted.

Step 6: To check a different assignment:

. Go back to the parent directory: **cd..**
. Run the copilot script: **./copilot_shell_script.sh**
. Enter your name again
. Enter the new assignment name (e.g., Git, Shell Basics)
. The app will display updated submission reminders

Access control: 

. Only names listed in the sample (submissions.txt) are accepted
. This prevents unauthorized users from viewing private data 
