
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class RequestGenerator {

    public static void main(String[] args) throws Exception {
        if (args.length > 0) {
            File file = new File(args[0]);

            FileInputStream fis = new FileInputStream(file);
            BufferedReader br = new BufferedReader(new InputStreamReader(fis));

            String line = br.readLine();
            Pattern request = Pattern.compile("(POST|GET|PUT) ([A-Za-z/.\\?=_0-9%&-]*)");
            Pattern orgRequest = Pattern.compile("(https://[a-zA-Z./0-9-#]*)");

            int cnt = 0;
            while (line != null) {
//                System.out.println(line);

                Matcher requestMatcher = request.matcher(line);
                Matcher orgRequestMatcher = orgRequest.matcher(line);

                if (requestMatcher.find() && orgRequestMatcher.find()) {
                    System.out.println("# Referer Request:::" + orgRequestMatcher.group(1));
                    System.out.println("echo 'Request Counter: " + ++cnt + "'");
                    System.out.println(args[1] + requestMatcher.group(2));
                }

                line = br.readLine();
            }
        } else {
            System.out.println(":::Access Replay:::\n");
            System.out.println("This process happens in 3 steps:\n" +
                    "1. Run the Java command, which will generate curl commands and write to a output.sh file.\n" +
                    "2. Run chmod command on the output.sh to enable execute access.\n" +
                    "3. Run output.sh to send requests to the servers.\n\n");
            System.out.println("Command syntax:: java RequestGenerator <absolute path to AEM or Apache access log> <command prefix>\n");
            System.out.println("\n::Example Usages::\n" +
                    "For full response Use:  " +
                    "\njava RequestGenerator \"/logs/access.log\" \"curl https://www.example.com\" > output.sh\n" +
                    "\nFor HTTP output code use:  " +
                    "\njava RequestGenerator \"/logs/access.log\" \"curl -I https://www.example.com\" > output.sh\n"
            );
        }
    }
}
