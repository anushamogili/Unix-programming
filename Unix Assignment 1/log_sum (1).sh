#!/bin/bash
numberOfLines=$2
caseToExecute=$3
LogFile=$4
echo "$2"
echo "$3"
echo "$4"

case $caseToExecute in

    -c)
      echo "List of IP address  which makes the most number of connection attempts are:"

          
	if [ $1 = '-n' ];then
		cat $LogFile | cut -f1 -d ' ' | sort -n| uniq -c | sort -g -r |head $numberOfLInes
	else 
		cat $LogFile | cut -f1 -d ' ' | sort -n| uniq -c | sort -g -r 
	fi
   ;;
    -2)
       echo "List of IP address which makes the most number of successful attempts are:"
	if [ $1 = '-n' ];then
           cat $LogFile| awk '{ print $1 , " " ,$9}'|grep " 200"| sort -n |uniq -c|sort -nr|head $numberOfLInes
else
  cat $LogFile| awk '{ print $1 , " " ,$9}'|grep " 200"| sort -n |uniq -c|sort -nr
fi
   ;;
    -r) 
      echo "the most common results codes and there ip address are:"
	#echo "$(if [ $1 = '-n' ];then 
#echo "most results"
	echo $FILENAME
	echo
	echo $1
         if [ $1 = '-n' ]; then 
            cat $LogFile | awk '{print $1 , " " , $9 }'|sort  -k1,9 >test3.txt
               cat test3.txt | sort -n |uniq -c | sort -nr |head $numberOfLInes 
  else
           cat $LogFile | awk '{print $1 , " " , $9 }'|sort  -k1,9 >test3.txt
               cat test3.txt | sort -n |uniq -c | sort -nr 
          fi 

 
   ;;
    -F)
     echo "the most common result codes that indicate failure and there ip address are:"
echo $FILENAME
	echo
	echo $1
         if [ $1 = '-n' ]; then 
         cat $LogFile | awk '{print $1 , " " , $9 }'|grep -v  " 200" |sort  -k1,9 >t.txt
               cat $LogFile | awk '{print $1 , " " , $9 }'|sort  -k1,1| awk '{print $2}'| sort -rn | uniq -c |head -1 | awk '{print $2}'
                  cat t.txt |grep "404"| head $numberOfLInes
         else
             cat $LogFile | awk '{print $1 , " " , $9 }'|grep -v  " 200" |sort  -k1,9 >t.txt
               cat $LogFile | awk '{print $1 , " " , $9 }'|sort  -k1,1| awk '{print $2}'| sort -rn | uniq -c |head -1 | awk '{print $2}'
                  cat t.txt |grep "404"
         fi
    ;;
     -t) 
       echo "IP numbers with the most bytes sent to them are :"
  	if [ $1 = '-n' ];then

          awk '{ total[$1]+=$10 }END{ for(sum in total) 
if (total[sum]) 
print sum,total[sum] }' $LogFile > bytes.txt
              cat bytes.txt| sort -nr -k 2,2||head $numberOfLInes
else
awk '{ total[$1]+=$10 }END{ for(sum in total) 
if (total[sum]) 
print sum,total[sum] }' $LogFile > bytes.txt
              cat bytes.txt| sort -nr -k 2,2
fi
    ;;
     -e)
         echo " the DNS blacklist:"
    cat blacklist.txt | awk '{print $1 , " " ,  $3}' | nslookup $1 > list.txt
   cat list.txt | grep "Address" > ipadd.txt
cat $LogFile | awk '{print $1}' > logip.txt

echo "$(filename="logip.txt"
while IFS= read -r line; do

    X=$(grep "^${line}$" "ipadd.txt")

    if [[ -z $X ]] ; then
       echo "$line"
    else 
        printf "%s \t blacklist\n" "$line"; 
 
    fi
done < "$filename")" 

 
      ;;
esac





