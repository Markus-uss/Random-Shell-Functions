#!/bin/bash

#If there are 5 files in ~/.config/logs/, begin process.
if [[ $(find ~/.config/logs/*.log | wc -l) -ge 5 ]];
	then
		#Create a new directory if it doesn't exist.
		if [ ! -d backups-$(date +"%d-%m") ];
			then
				echo "Creating New Directory"
				mkdir backups-$(date +"%d-%m")
			fi
		#Move all the log files to the backup directory.
		echo "Moving Logs Files"
		for log in $(find ~/.config/logs/*.log);
			do
				mv $log backups-$(date +"%d-%m")
			done	
		#Compress the directory and move it to ~/.configs/log/backups
		$(tar -czf $(date +"%d-%m").tar.gz ~/.config/logs/backups-$(date +"%d-%m"))
		$(rsync -a ~/.config/logs/$(date +"%d-%m").tar.gz ~/.config/backup-logs)
	fi
