#!/bin/bash

if [ "$#" -ne 5 ]; then
    printf "USAGE::\n./componentUsageReport.sh \"/apps/geometrixx\" \"/content/geometrixx\" \"admin:admin\" \"localhost\" \"4502\"\n"
    exit
fi

#Get query from user:
#printf "\nEnter Apps Path (eg: /apps/geometrixx ):\n"
APP_PATH=$1

#printf "\nEnter Content Path (eg: /content/geometrixx ):\n"
CONTENT_PATH=$2

#printf "\nEnter username:password:\n"
upass=$3

#printf "\nEnter hostname:\n"
host=$4

#printf "\nEnter port:\n"
port=$5

printf "\nProcessing........\n"

rm -rf ./*.csv
rm -rf ./*.out

eval curl -G  --silent  -u admin:admin --data-urlencode \""stmt=/jcr:root${APP_PATH}//*[@jcr:primaryType = 'cq:Component']"\" --data-urlencode '_charset_=utf-8' --data-urlencode 'type=xpath' --data-urlencode 'showResults=true' 'http://localhost:4502/crx/de/query.jsp' > query.out

cat query.out  | grep -o '"path":"[a-z._A-Z0-9/:-]*"' | grep -o '/[^"]*' | sort > sort.out

echo "Component Title, No. Of Occurances across the site, Component Path, Activation status" >> ./draft.csv

while read FILE_PATH; do

       R_TYPE=$(echo "${FILE_PATH}" | sed 's|/apps/||')
       
	  C_TITLE=$(curl -sL -u ${upass} http://${host}:${port}/${FILE_PATH}.json | grep -o '"jcr:title":"[A-Za-z0-9 ]*"')
	         
	  eval curl -G  -silent -u ${upass} --data-urlencode \""stmt=/jcr:root${CONTENT_PATH}//*[@sling:resourceType = '${R_TYPE}']"\" --data-urlencode '_charset_=utf-8' --data-urlencode 'type=xpath' --data-urlencode 'showResults=true' 'http://${host}:${port}/crx/de/query.jsp' > query1.out
	  
	  cat query1.out  | grep -o '"path":"[a-z._A-Z0-9/:-]*"' | grep -o '/[^"]*' > pages.out
	  
	  COUNT=$(cat query1.out | grep -o '"total":[0-9]*')
	  
	  while read PAGE_PATH; do
	  
	  	ONLY_PAGE_PATH=$(echo ${PAGE_PATH} | grep -o "/content/(.*)jcr:content")
	  
	  	PUB_STATUS=$(curl -sL -u ${upass} http://${host}:${port}/${ONLY_PAGE_PATH}.json | grep -o '"cq:lastReplicationAction":"[A-Za-z0-9 ]*"')

		PUB_STATUS=$([ ! -z "$PUB_STATUS" ] || echo "Not-activated")
	  
	  	echo "${C_TITLE}, ${COUNT}, ${PAGE_PATH}, ${PUB_STATUS}" >> ./draft.csv
	  
	  done <pages.out

done <sort.out

cat draft.csv | sed 's|\"jcr:title\":||' |  sed 's|\"total\":||' > final.csv

printf "\nProcessing Complete. Output in file:: final.csv\n"
open ./final.csv

