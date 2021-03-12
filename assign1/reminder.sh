#!/bin/bash

optionUsed=False

#Checks if reminders directory exists, otherwise create one.
if [[ ! -d ~/.config/reminder.sh ]]; then
	echo "Creating new reminder directory."
	$(mkdir ~/.config/reminder.sh)
fi

#Checks if reminders file exist, otherwise create one.
if [[ ! -f ~/.config/reminder.sh/reminders ]]; then
	echo "Creating new reminders file."
	$(touch ~/.config/reminder.sh/reminders)
fi

#Checks if an option was used.
while getopts "ACD:" option; do
	case $option in
		#if the option is -A, create new file.
		A)
			if [ "$#" -ge 2 ]; then

				echo "Creating a new reminder."
				echo "Reminder: '$2' has been added."
				$(echo $2 >> ~/.config/reminder.sh/reminders)
				optionUsed=True
			else
				echo "Wrong input! Do: -A 'Text to add'"
			fi
			;;

		#if the option is -C, modify a name file.
		C)
			if [ "$#" -ge 3 ]; then
				echo "Modifying a reminders."
				$(sed -i "s/$2/$3/g" ~/.config/reminder.sh/reminders)
				optionUsed=True
			else
				echo "Wrong input! Do: -C 'Reminder to replace' 'Replacing Reminder'"
			fi
			;;
		D)
			if [ "$#" -ge 2 ]; then
				echo "Deleting a reminder."
				$(sed -i "/$2/d" ~/.config/reminder.sh/reminders)
				optionUsed=True
			else
				echo "Wrong input! Do: -D 'Reminder to remove'"
			fi
			;;

		?)
			echo "Use -A 'Reminder' to create new reminders, or -C 'Reminder' to modify reminders."
	esac
done

#If no arguments are given, list out reminders.
if [ "$#" -eq 0 ]; then
	$(echo cat ~/.config/reminder.sh/reminders)
elif [ $optionUsed == False ]; then
	echo "Arguments given, but not used."
	$(echo cat ~/.config/reminder.sh/reminders)
fi

#Prints exit status.
if [ "$?" -eq 0 ]; then
	echo "Script successfully executed."
else
	echo "Error occurred."
fi
