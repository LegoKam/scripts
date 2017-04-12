**Access Replay Acces Log Shell Based**

Replays the URLs in the access log sending traffic to the server thats specified in the command line.
Note the access log assumes all URLs to be HTTP method:GET even if its a POST or anything else.

**Syntax:**
```
./accesLogReplay.sh <publisher or dispatcher access log> <path to where the log and the results should be output> <URL prefix>  <[uniq | all]>
``` 
**Example: (Will sort the access log paths, make them unique and they try accessing each url)**
```
./accesLogReplay.sh /projects/customer/access.log /projects/customer/log http://localhost:4503 uniq
``` 
**Example: (Will replay access log after sorting them)**
```
./accesLogReplay.sh /projects/customer/access.log /projects/customer/log http://localhost:4503 all
```
The output will be sent to results.csv file (for my example above):
```
/projects/customer/log/results.<timestamp>.csv
```

** CAUTION **
* First try with a small acces.log files (say:100 lines) to get the command right and also get an understanding of how it works before replaying a log file from production which at some customers could be well over a million lines.
