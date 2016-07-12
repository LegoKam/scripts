#Get query from user:
printf "\nEnter SQL2 Query:\n"
read query

printf "\nEnter username:password:\n"
read upass

printf "\nEnter hostname:\n"
read host

printf "\nEnter port:\n"
read port

#Curl Command to fetch the list of activated files
eval "curl -G  --silent  -u ${upass} --data-urlencode 'stmt=${query}' --data-urlencode '_charset_=utf-8' --data-urlencode 'type=JCR-SQL2' --data-urlencode 'showResults=true' 'http://${host}:${port}/crx/de/query.jsp' >  queryOut.txt"

#Filter out only the path
cat queryOut.txt  | grep -o '"path":"[a-z._A-Z0-9/:-]*"' | grep -o '/[^"]*' | sort > sort.txt

#Count the no. of nodes:
printf "\nNo. of nodes ready for replication:\n"
cat sort.txt | wc -l

printf '\nTo See replication status run command in a different console:\ntail -f ./crx-quickstart/logs/error.log | grep "(ACTIVATE)"\n'
printf "\nPress any key to start replicating.....\n"
read key

#Replicate one by one.
while read FILE_PATH; do
  eval "curl -u ${upass} 'http://${host}:${port}/crx/de/replication.jsp' --data 'path=${FILE_PATH}&action=replicate&_charset_=utf-8' --compressed"
done <sort.txt

printf "\nReplication complete.\n\n"



