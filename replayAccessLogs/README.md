:::Access Replay::: (Deprecated)
New one available here: https://github.com/LegoKam/scripts/tree/master/replayAccessLogsShell

This process happens in 3 steps:
1. Run the Java command, which will generate curl commands and write to a output.sh file.
2. Run chmod command on the output.sh to enable execute access.
3. Run output.sh to send requests to the servers.


Command syntax:: java RequestGenerator "absolute path to AEM or Apache access log" "command prefix"


::Example Usages::
For full response Use:  
java RequestGenerator "/logs/access.log" "curl https://www.example.com" > output.sh

For HTTP output code use:  
java RequestGenerator "/logs/access.log" "curl -I https://www.example.com" > output.sh

