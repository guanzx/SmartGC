#!/bin/bash
##################
#	Author:guanzx
#	Desc:主要用于删除日志的操作
#
##################
while getopts ":p:o:f:l:" option
do
	case "$option" in
		
		p)
			if [[ $OPTARG == -* ]]
			then				
				echo "-t need an argument" 
				exit 1
			fi		
		  	pathDir=$OPTARG
		            
		;;
				
		o)
			if [[ $OPTARG == -* ]]
			then				
				echo "-t need an argument" 
				exit 1
			fi		
		  	operation=$OPTARG
		            
		;;
		
		f)
			if [[ $OPTARG == -* ]]
			then				
				echo "-t need an argument" 
				exit 1
			fi		
		  	fileDir=$OPTARG
		            
		;;
			
		l)
			if [[ $OPTARG == -* ]]
			then				
				echo "-t need an argument" 
				exit 1
			fi		
		  	limit=$OPTARG
		            
		;;
		
		?)
		
		echo "usage $0:>" 
		exit 1
		
		;;
			
	esac

done


deleteWholeDirData() {
	for fileName in `ls -A $1`
	do
		if test -f $1/$fileName
		then			
			echo "$1/$fileName"
			rm $1/$fileName				
	    elif test -d $1/$fileName
		then
			rm -rf $1/$fileName
		fi
	done
}

deleteConcreteData() {
	current_date=$(date +%Y%m%d)
	rm_date=$(date -d "$current_date - $2 days" +%Y%m%d)
	yyyy=${rm_date:0:4}
	mm=${rm_date:4:2}
	dd=${rm_date:6:2}
	
	for fileName in `ls -A $1`
	do
		if test -f $1/$fileName
		then			
			fileDate=${fileName##*_}
			filePrefix=${fileName#*_}
			preFormat=${format#*_}
			if [[ preFormat == filePrefix ]]
			then			
				ymdStr=${fileDate:0:8}
				if (( $ymdStr <= $rm_date ))
				then
					rm $1/$fileName
				fi
			fi		
		fi
	done
}

if [[ $limit != "" ]]
then
	deleteConcreteData $fileDir $limit	
else
	if [[ $pathDir != "" ]]
	then	
		deleteWholeDirData $pathDir
	fi
	
	if [[ $fileDir != "" && $operate != "" ]]
	then
		deleteWholeDirData $fileDir
	fi
fi