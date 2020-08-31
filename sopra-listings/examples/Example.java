import java.util.Scanner;
// Further imports, maybe
|ihl|Diese Zeile wird künstlich hervorgehoben|ihl|

@ImportantAnnotation
public class Example {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        while (true) { /* go on forever */
            String s = scanner.nextLine();
            if (s.equals("exit"))
                break;
            System.out.println(s);
        }
        System.out.println("2 + 2 is " + (2+2));
        scanner.close();
    }
}
