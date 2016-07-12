
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
            System.out.println("\n**Access Log Replay**\n\nCommand syntax:: java RequestGenerator <absolute path to AEM access log> <command prefix>\n");
            System.out.println("java RequestGenerator \"/aem/crx-quickstart/logs/access.log\" \"curl -u admin:admin https://v.author.tcom.corp.telstra.com\" > output.sh\n");
        }
    }
}
