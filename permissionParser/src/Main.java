import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {

    public static void main(String[] args) throws IOException {

        File aemRoot = new File("/Volumes/dam/assetinsights");

        String list[] = aemRoot.list();

        for (String item : list) {

            StringBuilder sb = new StringBuilder("/");
            sb.append(aemRoot.getName()).append(File.separatorChar).append(item);

            StringBuilder command = new StringBuilder("curl -u admin:admin http://localhost:4502/crx/de/ace.jsp?path=");
            command.append(sb.toString()).append("&principal=admin&action=test&_charset_=utf-8");

            System.out.println("\n\n" + command + "\n\n");

            Runtime rt = Runtime.getRuntime();
            Process process = rt.exec(command.toString());

            BufferedReader stdInput = new BufferedReader(new InputStreamReader(process.getInputStream()));
            BufferedReader stdError = new BufferedReader(new InputStreamReader(process.getErrorStream()));

            System.out.println("Here is the standard output of the command:\n");
            String s = null;
            while ((s = stdInput.readLine()) != null) {
                System.out.println(s);

                //obj = JSON.parse(s);


            }



        }
    }
}
