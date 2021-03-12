#!/bin/bash

foundDirectory=False

#Checks if trash directory exists in root, else create one.
echo "Looking for trash directory."
if [[ -d ~/trash ]]; then
	echo "Trash directory found."
else
	echo "Creating new trash directory."
	$(mkdir ~/trash)
fi

#Checks if an option is used
while getopts "d:" option; do
	case $option in
		#If the option is -d, move directories as well.
		d)
			echo "Looking for '$2'."
			if [[ -d $2 ]]; then
				echo "'$2' found."
				$(cp -r $2 ~/trash)
				$(rm -r $2)
				foundDirectory=True
			else
				echo "'$2' not found."
			fi
			;;
		#If the option is unknown, tell the user to use -d.
		?)
			echo "Use '-d' to remove directories."
			;;
	esac
done

#If the file exists.
if [ -f $1 ]; then
	echo "Moving '$1' to trash."
		$(cp $1 ~/trash)
		$(rm $1)
else
	#If directory is found, inform user to use -d. Else file does not exist.
	if [[ -d $1 ]]; then
		echo "Use '-d' to delete directories."
	elif [ $foundDirectory == False ]; then	
		echo "File does not exist."
	fi
fi

#Exit Status.
if [ "$?" -eq "0" ]; then
	echo "Script successfully executed."
else
	echo "Error occurred."
fi
