#!/bin/bash
if [ $# -lt 2 ] 
then
	echo "Usage $0 MMDD HH:mm:ss:[AM|PM]"
	echo "For example: $0 0315 02:00:00:AM"
	exit 1
fi
Dealer_Results=/03-student/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis/Dealer_Combined
Date=$1
Time=$2
Concat_Time="$1:$2"
echo "$Concat_Time"
Dealer_Info=`grep  $Concat_Time $Dealer_Results | awk '{print $1,$4,$5;}'`
printf "Here is the Roulette dealer for the time you selected:\n $Dealer_Info \n" 

