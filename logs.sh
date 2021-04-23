#!/bin/bash

#If an error message is detected, begin the saving process.
if [[ $(sudo dmesg -l warn,err) ]];
	then
		#Creates and Saves logs to log file.
		echo "Saving Logs"
		$(sudo dmesg -l warn,err > ~/.config/logs/warning-$(date +"%d-%m-%k-%M").log)
		echo "Process Complete"
	fi
