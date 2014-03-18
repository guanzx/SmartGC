#!/bin/bash

while getopts ":b:p:f:o:l:d:" option
do
	case "$option" in
	
		b) 
		   if [[ $OPTARG == -* ]]
		   then
				echo "-j need an argument"  
				exit 1
		   fi 
		   baseDir=$OPTARG		
		;;
		
		p)
			if [[ $OPTARG == -* ]]
			then				
				echo "-t need an argument" 
				exit 1
			fi		
		  	pathDir=$OPTARG
		            
		;;
		
		f)
			if [[ $OPTARG == -* ]]
			then				
				echo "-t need an argument" 
				exit 1
			fi		
		  	format=$OPTARG
		            
		;;
		
		o)
			if [[ $OPTARG == -* ]]
			then				
				echo "-t need an argument" 
				exit 1
			fi		
		  	operation=$OPTARG
		            
		;;
		
		l)
			if [[ $OPTARG == -* ]]
			then				
				echo "-t need an argument" 
				exit 1
			fi		
		  	limit=$OPTARG
		            
		;;
		
		d)
			if [[ $OPTARG == -* ]]
			then				
				echo "-t need an argument" 
				exit 1
			fi		
		  	deleteall=$OPTARG
		            
		;;
		
		
		?)
		
		echo "usage $0:>" 
		exit 1
		
		;;
			
	esac

done


# 先针对mc.conf进行coding,然后再此基础上进行优化重构

cd $baseDir
. /mc.conf

stat_date=$(date +%Y%m%d)

if [[ $operation == 'delete' ]]
then
	
	rm_date=$(date -d "$stat_date - $limit days" +%Y%m%d)
	yyyy=${rm_date:0:4}
	mm=${rm_date:4:2}
	dd=${rm_date:6:2}
	
	for file1 in `ls -A $pathDir`
	do
			if test -f $pathDir/$file1
			then
				dateStr=${file1##*_}
				preFormat=${file1#*_}
				preFormat1=${format#*_}
				if [[ preFormat == preFormat1 ]]
				then			
					ymdStr=${dateStr:0:8}
					if (( $ymdStr <= $rm_date ))
					then
						rm $pathDir/$file1
					fi
				fi
	done
fi



