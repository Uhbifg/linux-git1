#!/bin/bash
# saner programming env: these switches turn some bugs into errors
set -o errexit -o pipefail -o noclobber -o nounset
echo "maximum price by year"
awk -F, 'BEGIN{max=0; year=0}NR>1{cur=substr($1, 0, 5)}NR==2{year=cur}$5-max>0{max=$5;max+=0.0}cur>year{print "max in", year, max ; year=cur;max=$5}END{print "max in", year, max}' "$1"
echo "______"
awk -F, 'BEGIN{x=0}NR>1{x+=$2}END{print "all time average price", x/(NR-1)}' "$1"
echo "______"
echo "average monthly price in 2020"
awk -F, 'BEGIN{month=1;count=0;sum=0}substr($1, 0, 5)==2020{cur_month=substr($1, 6, 2)+0;sum+=$5;count+=1}month<cur_month,substr($1, 0, 5)==2020{print "month:",month,"average",sum/(count+1) ; month=cur_month; count=1; sum = $5 + 0.0}END{print "month:", month,"average:" ,sum/count}' "$1"
echo "_____"
python3 'main.py'
