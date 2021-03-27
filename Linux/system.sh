#!/bin/bash

# This script will do the following (the home_dir is /home/sysadmin):
# Print the amount of free memory on the system and save it to $home_dir/backups/freemem/free_mem.txt.
# Prints disk usage and saves it to $home_dir/backups/diskuse/disk_usage.txt.
# Lists all open files and saves it to $home_dir/backups/openlist/open_list.txt.
# Prints file system disk space statistics and saves it to $home_dir/backups/freedisk/free_disk.txt.
# The reason it isn't proper to user ~ for home directory, is this script will be run
#in a cron weekly jog
# and will therefore be run as root. Since the backups folders are relative to
#/home/sysadmin, we need to set an absolute path
current_time=$(date +"%m%d%Y")
home_dir=/home/sysadmin
backups_dir=$home_dir/backups
# Free memory output to a free_mem.txt file
free -h > $backups_dir/freemem/free_mem_$current_time.txt

# Disk usage output to a disk_usage.txt file
du -h > $backups_dir/diskuse/disk_usage_$current_time.txt

# List open files to a open_list.txt file
lsof > $backups_dir/openlist/open_list_$current_time.txt

# Free disk space to a free_disk.txt file
df -h> $backups_dir/freedisk/free_disk_$current_time.txt
