#!/bin/bash
# File: loss_investigation.sh
# Author: Bob Huyck
# This script will take several log files
# determine when losses occurred, and 
# format this data into consistent fields, in
# order to make searches easier.
# Since the dates are not present in the log files
# it will be necessary to derive the date from the file names
# themselves, and concatenate this into the analysis files.
# The delimiting structures of the Player files are not consistent,
# so it will be necessary to modify the structure to allow for easier searches for the players 
# involved.
# We didn't discuss the use of tick character to invoke command
# execution when setting variables, but it was discussed on
# cyberaces tutorial, which was suggested learning for course 
# prerequisite.

Base_Dir=/03-student/Lucky_Duck_Investigations/Roulette_Loss_Investigation
Player_Analysis_Dir=$Base_Dir/Player_Analysis
Roulette_Losses_File=$Player_Analysis_Dir/Roulette_Losses
Dealer_Analysis_Dir=$Base_Dir/Dealer_Analysis
Dealer_Combined_File=$Dealer_Analysis_Dir/Dealer_Combined
Player_Dealer_Correlation_Dir=$Base_Dir/Player_Dealer_Correlation
Dealers_File=$Player_Dealer_Correlation_Dir/Dealers
TMP_Dir=$Base_Dir/tmp
Player_TMP_Dir=$TMP_Dir/Players
Dealer_Data_Result=$TMP_Dir/Dealer_Data
Player_Data_Result=$TMP_Dir/Player_Data
Player_Dealer_Correlation_Notes=$Base_Dir/Player_Dealer_Correlation/Notes_Player_Dealer_Correlation
Player_Notes=$Base_Dir/Player_Analysis/Notes_Player_Analysis
Dealer_Notes=$Base_Dir/Dealer_Analysis/Notes_Dealer_Analysis
printf "We are going to check the times when we \nhad losses, and find out the Dealers and Players \nwho might be involved\n\n"
#We will first delete the $TMP_Dir and , then create it as well as the $Player_TMP_Dir. 
#It may not exist, so we may get an error message
rm -rf $TMP_Dir
mkdir $TMP_Dir

mkdir $Player_TMP_Dir
cd $Dealer_Analysis_Dir
# Dealer_Schedule files for the dates in question were moved to the
# Dealer_Analysis directory. Now, in order to ensure that all the lines are cat'd
# into the single file, and that the date is prepended
# to the time, we grep on the letter m, since all times will be either AM or PM.
# we will also remote everything after the date from the filename, so that 
# we have date:time. In the awk output, we also remove the field separator for the first two 
# fields, so we then will have date:timeAM or date:timePM. We will perform the same type of operation
# on the win_loss_player_data files, when we output this data to the $Roulette_Losses_File
grep -i m 03* | sed s/_Dealer_schedule// |awk '{print $1":"$2,$3,$4,$5,$6,$7,$8;}' >$Dealer_Combined_File
grep -i m 03* | sed s/_Dealer_schedule/" "/ |sed s/:/\s/ |awk '{print $1":"$2,$3,$4,$5,$6,$7,$8;}' >$Player_TMP_Dir/TestFile
cd $Player_Analysis_Dir
#The one difference in the way we deal with the formatting of the win_loss_player_data
# is that we also need to fix the formatting, since part of the file is delimited 
# by whitespace, and the player info is delimited by comma.
# Since we also will have commas in the field that contains the loss info, it
# will be simpler to just not print that from awk, and then insert commas 
# for the fields that were previously separated by whitespace. We 
# will also number the lines in the $Roulette_Losses_File, so that we can grep on the
# line number word

grep '\-\$' 031* |sed s/_win_loss_player_data// |awk '{print ","$1":"$2",",$4,$5,$6,$7,$8,$9,$10,$11,$12,$13;}' |cat -n>$Roulette_Losses_File

# We now want to find out how many losses we incurred, and will
# use this in a while loop. We haven't learned about while loops, but
# I am lazy, and I don't want to write a lot of lines of code.
Matching_lines="`wc -l "$Roulette_Losses_File" |awk '{print$1}'`"
#echo "Number of matching lines is: $Matching_lines"
Iteration=1
#echo "Iteration number is $Iteration"
while [ $Iteration -le $Matching_lines ]
do
#echo "We are in Iteration: $Iteration"
# I examined the number of players in
# the files, and there were only 
grep `grep -E "(^| )$Iteration(\s)" $Roulette_Losses_File|awk -F, '{print $2}' ` $Dealer_Combined_File |awk '{print $1,$4,$5}'| sed s/.*Dealer_Combined://>$TMP_Dir/Dealer_Hour_$Iteration
Username1="`grep -E "(^| )$Iteration(\s)" $Roulette_Losses_File |awk -F, '{print $3}'`"
if [ ! -z "$Username1" ]
then
#echo "Player 1 Hour $Iteration User is: $Username1"
Player1=`echo $Username1 |awk '{print $1"_"$2;}'`
touch $Player_TMP_Dir/$Player1
fi
Username2="`grep -E "(^| )$Iteration(\s)" $Roulette_Losses_File |awk -F, '{print $4}'`"
if [ ! -z "$Username2" ]
then
#echo "Player 2 Hour $Iteration User is: $Username2"
Player2=`echo $Username2 |awk '{print $1"_"$2;}'`
touch $Player_TMP_Dir/$Player2
fi
Username3="`grep -E "(^| )$Iteration(\s)" $Roulette_Losses_File |awk -F, '{print $5}'`"
if [ ! -z "$Username3" ]
then
#echo "Player 3 Hour $Iteration User is: $Username3"

Player3=`echo $Username3 |awk '{print $1"_"$2;}'`
touch $Player_TMP_Dir/$Player3

fi
Username4="`grep -E "(^| )$Iteration(\s)" $Roulette_Losses_File |awk -F, '{print $6}'`"
if [ ! -z "$Username4" ]
then
#echo "Player 4 Hour $Iteration User is: $Username4"
Player4=`echo $Username4 |awk '{print $1"_"$2;}'`
touch $Player_TMP_Dir/$Player4
fi
Username4="`grep -E "(^| )$Iteration(\s)" $Roulette_Losses_File |awk -F, '{print $6}'`"
if [ ! -z "$Username5" ]
then
#echo "Player 5 Hour $Iteration User is: $Username5"
Player5=`echo $Username5 |awk '{print $1"_"$2;}'`
touch $Player_TMP_Dir/$Player5
fi
Username6="`grep -E "(^| )$Iteration(\s)" $Roulette_Losses_File |awk -F, '{print $6}'`"
if [ ! -z "$Username6" ]
then
#echo "Player 6 Hour $Iteration User is: $Username6"
Player6=`echo $Username6 |awk '{print $1"_"$2;}'`
touch $Player_TMP_Dir/$Player6
fi
 ((Iteration++))
done
printf "Hour_of_loss Roulette_Dealer_Fname Roulette_Lname \n" >$Dealer_Data_Result
cat $TMP_Dir/Dealer_Hour_* >$Dealers_File
printf "`cat $Dealers_File |awk '{print $1,$2,$3}'`\n" >>$Dealer_Data_Result
Player_Data=`ls $Player_TMP_Dir | cat -n |sed s/"_"/" "/`
#echo "$Player_Data"
Player_Lines=`ls $Player_TMP_Dir | wc -l`
echo "$Player_Data" >$TMP_Dir/Player
printf "Player_Fname Player_Lname Occurrences \n" >$Player_Data_Result

#echo "Player_Lines $Player_Lines" 
var=1
while [ $var -le $Player_Lines ]
 do 
Player_name="`grep -w $var $TMP_Dir/Player|awk '{print $2,$3}'`"
#grep -w $var $TMP_Dir/Player|awk '{print $2,$3}'
Player_match="`grep "$Player_name" $Roulette_Losses_File | wc -l`"
printf "$Player_name $Player_match \n">>$Player_Data_Result
((var++))
  done
#printf "Here is the info on Roulette Dealers during the losses: \n"
cat $TMP_Dir/Dealer_Data >$Dealer_Notes
#printf "\nHere is the info on Players: \n"
cat $TMP_Dir/Player_Data>$Player_Notes
cat $Dealer_Notes $Player_Notes >$Player_Dealer_Correlation_Notes
# cat $Dealer_Notes
# cat $Player_Notes
# cat $Player_Dealer_Correlation_Notes

