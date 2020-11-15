#!/bin/sh
USER="$1"
TOKEN="Authorization: token "`cat token`
curl -s -H "$TOKEN" 'https://api.github.com/repos/datamove/linux-git2/pulls?state=all&page=1&per_page=100' >> /tmp/out.txt
curl -s -H "$TOKEN" 'https://api.github.com/repos/datamove/linux-git2/pulls?state=all&page=2&per_page=100' >> /tmp/out.txt
curl -s -H "$TOKEN" 'https://api.github.com/repos/datamove/linux-git2/pulls?state=all&page=3&per_page=100' >> /tmp/out.txt
ans1=`cat /tmp/out.txt | jq '.[].user.login' | grep -w "$USER" -c|sed 's/ //g'`
echo  PULLS $ans1
ans2=`cat /tmp/out.txt | jq  ".[] | {number: .number, name: .user.login, merged: .state}" | jq -s | jq -r '(.[0] | keys_unsorted) as $keys | ([$keys] + map([.[ $keys[] ]])) [] | @csv' | awk -F, -v var="\"$USER\"" '$2==var{print $1, ",", $3}' | awk -F, 'BEGIN{min=-1}min<0{min=$1}min>$1{min=$1}END{print min}'|sed 's/ //g'`
echo EARLIEST $ans2
url="https://api.github.com/repos/datamove/linux-git2/commits/""$ans2""/merge"
ans3=`curl -s -H "token" "https://api.github.com/repos/datamove/linux-git2/pulls/65/merge" | jq '.message' | awk -F, '$1=="\"Not Found\""{print 0}$1=="\"No Content\""{print 1}'`
echo MERGED $ans3
rm /tmp/out.txt

