#Replay Access Logs

Here is the tool that will parse the access.log file and generate curl commands that can be used to generate production like traffic on Author and Publish servers.

Contents:
RequestGenerator.java :: source code

Syntax:
java RequestGenerator <absolute path to AEM access log> <command prefix>

Example:
java RequestGenerator "/<AEM_HOME>/logs/access.log" "curl -u <uname>:<pass> http://<hostname>" > output.sh

This tool will come in handy when you load test. Parallel to this ensure you replicate a code package  at a certain frequency fully flush the dispatcher cache.
This will ensure the Author and the Publish servers are fully tested.

