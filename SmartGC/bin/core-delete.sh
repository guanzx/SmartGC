#!/bin/bash
##################
#	Author:guanzx
#	Desc:主要用于删除日志的操作
#
##################
while getopts ":p:o:f:l:s:t:" option
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
		
		t)
			if [[ $OPTARG == -* ]]
			then				
				echo "-t need an argument" 
				exit 1
			fi		
		  	dateDir=$OPTARG
		            
		;;
		
		s)
			if [[ $OPTARG == -* ]]
			then				
				echo "-t need an argument" 
				exit 1
			fi		
		  	format=$OPTARG
		            
		;;
		
		?)
		
		echo "usage $0:>" 
		exit 1
		
		;;
			
	esac

done

deleteDataDir() {
	current_date=$(date +%Y%m%d)
	rm_date=$(date -d "$current_date - $2 days" +%Y%m%d)
	yyyy=${rm_date:0:4}
	mm=${rm_date:4:2}
	dd=${rm_date:6:2}
	for fileName in `ls -A $1`
	do
		if [[ $fileName == [2-3][0-9][0-9][0-9][0-1][0-9][0-3][0-9] ]]
		then
			if (( $fileName <= $rm_date ))
			then			
				rm -rf $1/$fileName
			fi
	done

}

deleteConcreteFilewithDataDir() {
	current_date=$(date +%Y%m%d)
	rm_date=$(date -d "$current_date - $3 days" +%Y%m%d)
	yyyy=${rm_date:0:4}
	mm=${rm_date:4:2}
	dd=${rm_date:6:2}
	
	for fileName in `ls -A $1`
	do
		if [[ $fileName == [2-3][0-9][0-9][0-9][0-1][0-9][0-3][0-9] ]]
		then
			if (( $fileName <= $rm_date ))
			then			
				if test -d $1/$fileName
				then
					for subfileName in `ls -A $1/$fileName`
					do 
						if test -f $1/$fileName/$subfileName
						then
							fileDate=${subfileName##*_}
							filePrefix=${subfileName#*_}
							preFormat=${$2#*_}
							if [[ preFormat == filePrefix ]]
							then			
								ymdStr=${fileDate:0:8}
								if (( $ymdStr <= $rm_date ))
								then
									rm $1/$fileName/$subfileName
								fi
							fi		
						fi
					done
				fi
			fi
		fi
	done

}


deleteConceteFile() {
	current_date=$(date +%Y%m%d)
	rm_date=$(date -d "$current_date - $3 days" +%Y%m%d)
	yyyy=${rm_date:0:4}
	mm=${rm_date:4:2}
	dd=${rm_date:6:2}
	
	for fileName in `ls -A $1`
	do
		if test -f $1/$fileName
		then			
			fileDate=${fileName##*_}
			filePrefix=${fileName#*_}
			preFormat=${$2#*_}
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

deleteWholeDir() {
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

if [[ $format != "" ]]
then
	if [[ $dateDir != "" ]]
	then
		deleteConcreteFilewithDataDir $fileDir $format $limit
	else
		deleteConceteFile $fileDir $format $limit
	fi
else
	if [[ $fileDir != "" ]]
	then
		if [[ $dateDir != "" ]]
		then
			deleteDataDir $fileDir $limit
		else
			deleteWholeDir $fileDir
		fi
	else
		if [[ $pathDir != "" ]]
		then
			deleteWholeDir $pathDir
		fi
	fi
fi
		