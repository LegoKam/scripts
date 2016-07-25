This program takes a JCR query as an input, runs against a given server, the nodes from the query output is then forward replicated.

#Give Scripts access
chmod 777 ./replicateByQuery.sh

#Example run: Replicate all nodes that were modified between 10-June-2016 to 14-june-2016.
./replicateByQuery.sh 

Enter SQL2 Query:
SELECT p.* FROM [nt:base] AS p WHERE p.[cq:lastReplicated] >= CAST("2016-06-10T00:00:00.000Z" AS DATE) AND p.[cq:lastReplicated] <= CAST("2016-06-14T23:59:59.999Z" AS DATE)

Enter username:password:
admin:admin

Enter hostname:
localhost

Enter port:
4502

No. of nodes ready for replication:
      11

To See replication status run command in a different console:
tail -f ./crx-quickstart/logs/error.log | grep "(ACTIVATE)"

Press any key to start replicating.....


Replication complete.


