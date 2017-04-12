suffix=$(date +%s)
uniqcheck="uniq"

mkdir -p $2

awk -F\" '{print $2}' $1 > $2/all_paths.$suffix.out

awk '{print $2}' $2/all_paths.$suffix.out > $2/paths_only.$suffix.out

if [[ $4 == $uniqcheck ]];
then
    echo "Making access log paths unique."
    cat $2/paths_only.$suffix.out | sort | uniq > $2/curl_paths.$suffix.out
else
    echo "NOT - Making access log paths unique. This will put real load on the server."
    cat $2/paths_only.$suffix.out | sort  > $2/curl_paths.$suffix.out
fi

i=1
j=1
while read p; do  

	if (( $i == 1000 )) ; then
	   chmod 755 $2/command$j.$suffix.sh
	   bash $2/command$j.$suffix.sh >> $2/results.$suffix.csv &
	   j=$((j+1))
	   i=1
	fi

	echo curl -sL -w \"%{http_code} , %{url_effective}\\n\" -H \"User-Agent: Mozilla\/5.0 \(Macintosh\; Intel Mac OS X 10_11_6\) AppleWebKit\/537.36 \(KHTML, like Gecko\) Chrome\/54.0.2840.98 Safari\/537.36\" \"$3$p\" -o   /dev/null >> $2/command$j.$suffix.sh

	i=$((i+1))
done < $2/curl_paths.$suffix.out

bash $2/command$j.$suffix.sh >> $2/results.$suffix.csv &

