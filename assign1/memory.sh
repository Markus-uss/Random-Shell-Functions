#!/bin/bash

#If 0 arguments are given, show all running proccesses.
if [ "$#" -eq 0 ]; then

	ps -o comm,rss | awk 'NR>1 {$2=int(100*$2/1024)/100"MB";}{print;}' | column -t

#If more than 1 argument given, match output with given argument
else
	#Prints processes if there are matches.
	if [[ $(ps -o comm | grep $1) ]]; then
		#Grep command outputs the header
		ps -o comm,rss | grep "COMMAND\|$1" | awk 'NR>1 {$2=int(100*$2/1024)/100"MB";}{print;}' | column -t

	
	#If no outputs are given, print 'No matching patterns.'
	else
		echo "No matching patterns."
	fi
fi

#Prints exit status.
if [ "$?" -eq 0 ]; then
	echo "Script successfully executed."
else
	echo "Error occurred."
fi

