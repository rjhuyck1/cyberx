#!/bin/bash
if [ $UID -ne 0 ];
then 
echo "You must run this with sudo or as root"
exit
fi
output='/home/sysadmin/research/sys_info.txt'
research_dir='/home/sysadmin/research'
sudo_users=$(grep sudo /etc/group | awk -F: '{print $4}' | sed s/,/" "/g)
home_users=$(ls /home/)
lists=('/etc/passwd' '/etc/shadow')
if [ ! -d $research_dir ];
then
mkdir ~/research 2> /dev/null
fi
echo "A Quick System Audit Script" > $output
date >> $output
echo "" >> $output
echo "Machine Type Info:" >> $output
echo $MACHTYPE >> $output
echo -e "Uname info: $(uname -a) \n" >> $output
echo -e "IP Info: $(ip addr | grep -w inet | tail -2 | head -1) \n" >> $output
echo -e "Hostname: $(hostname -s) \n" >> $output
echo "DNS Servers: " >> $output
cat /etc/resolv.conf >> $output
echo -e "\nMemory Info:" >> $output
free >> $output
echo -e "\nCPU Info:" >> $output
lscpu | grep CPU >> $output
echo -e "\nDisk Usage:" >> $output
df -H | head -2 >> $output
echo -e "\nWho is logged in: \n $(who -a) \n" >> $output
echo -e "\nSUID Files:" >> $output
find / -type f -perm /4000 2>/dev/null 1>> $output
echo -e "\nTop 10 Processes" >> $output
ps aux -m | awk {'print $1, $2, $3, $4, $11'} | head >> $output


#Checking the permissions for shadow and passwd files
echo -e "\nChecking permissions on /etc/passwd and /etc/shadow" >> $output
for list in ${lists[@]};
do
echo -e "Permisions are $(ls -l $list)" >> $output
done

# Checking to see which users in /home are sudo users
echo -e "\nChecking to see which users in /home are sudo users" >> $output
for user in ${home_users[@]};
do
	
if [ $(echo ${sudo_users[@]}|grep -w $user 2>/dev/null) ];
then
echo "$user has sudo priviledges" 
fi
done
