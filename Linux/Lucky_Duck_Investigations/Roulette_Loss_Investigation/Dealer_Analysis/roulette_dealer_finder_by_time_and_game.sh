#!/bin/bash
complete_schedule=/03-student/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis/Dealer_Combined
Match=`printf $1:$2:$3`

if [ $# -lt 4 ] 
then
	echo "Usage $0 MMDD HH:mm:ss:[AM|PM] [blackjack|roulette|poker]"
	echo "For example: $0 0315 02:00:00:AM roulette"
	exit 1
fi
if [ $4 = 'blackjack' ]
then
        # echo $4
		# echo "blackjack"
		grep $Match $complete_schedule |  awk '{print $1,$2,$3}'
elif [ $4 = 'roulette' ]
then
        # echo $4
		# echo "roulette"
        grep $Match $complete_schedule | awk '{print $1,$4,$5}'
elif [ $4 = 'poker' ]
then
        # echo $4
		# echo "poker"
		grep $Match $complete_schedule | awk '{print $1,$6,$7}'
else
        echo "$4  is invalid input"
fi
