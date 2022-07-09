/**
 * CS 2110 Spring 2021 HW1
 * Part 2 - Coding with bases
 *
 * @author Jimin Sun
 *
 * Global rules for this file:
 * - You may not use more than 2 conditionals per method. Conditionals are
 *   if-statements, if-else statements, or ternary expressions. The else block
 *   associated with an if-statement does not count toward this sum.
 * - You may not use more than 2 looping constructs per method. Looping
 *   constructs include for loops, while loops and do-while loops.
 * - You may not use nested loops.
 * - You may not declare any file-level variables.
 * - You may not use switch statements.
 * - You may not use the unsigned right shift operator (>>>)
 * - You may not write any helper methods, or call any method from this or
 *   another file to implement any method. Recursive solutions are not
 *   permitted.
 * - The only Java API methods you are allowed to invoke are:
 *     String.length()
 *     String.charAt()
 * - You may not invoke the above methods from string literals.
 *     Example: "12345".length()
 * - When concatenating numbers with Strings, you may only do so if the number
 *   is a single digit.
 *
 * Method-specific rules for this file:
 * - You may not use multiplication, division or modulus in any method, EXCEPT
 *   decimalStringToInt, where multiplication is allowed
 * - You may declare exactly one String variable each in intToOctalString and
 *   and hexStringToBinaryString.
 */
public class Bases
{
    /**
     * Convert a string containing ASCII characters (in binary) to an int.
     *
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid binary numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: binaryStringToInt("111"); // => 7
     */
    public static int binaryStringToInt(String binary)
    {
        int len_binary = binary.length();
        int return_value = 0;
        int count = len_binary;
        int k = 0;
        while(count >  0){
            if (binary.charAt(k) == '1'){
                return_value += (1 << (len_binary - 1 - k));
            }
            count--;
            k++;
        }
        return return_value;
    }

    /**
     * Convert a string containing ASCII characters (in decimal) to an int.
     *
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid decimal numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: decimalStringToInt("46"); // => 46
     *
     * You may use multiplication (the * operator) in this method.
     */
    public static int decimalStringToInt(String decimal)
    {
        int len_decimal = decimal.length();
        int return_value = 0;
        int count = len_decimal;
        int char_to_multiply;
        int toMultiply = 1;
        while (count >  0){
            char_to_multiply = (int) decimal.charAt(count - 1) - '0';
            char_to_multiply = char_to_multiply * toMultiply;
            return_value += char_to_multiply;
            toMultiply *= 10;
            count--;
        }
        return return_value;

    }

    /**
     * Convert a string containing ASCII characters (in hex) to an int.
     *
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid hex numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: hexStringToInt("2B"); // => 43
     */
    public static int hexStringToInt(String hex)
    {
        int len_hex = hex.length();
        int return_value = 0;
        int count = len_hex;
        int numToMultiply;
        int k = 0;
        while (count > 0){
            if (hex.charAt(k) >= 65){
                numToMultiply = (int) (hex.charAt(k) - 7 - '0');
            } else {
                numToMultiply = (int) (hex.charAt(k) - '0');
            }
            return_value = (return_value << 4) + numToMultiply;
            count--;
            k++;
        }
        return return_value;
    }

    /**
     * Convert a int into a String containing ASCII characters (in octal).
     *
     * You do not need to handle negative numbers.
     * The String returned should contain the minimum number of characters
     * necessary to represent the number that was passed in.
     *
     * Example: intToOctalString(166); // => "246"
     *
     * You may declare one String variable in this method.
     */
    public static String intToOctalString(int octal)
    {
        String return_value = "";
        if (octal == 0){
            return_value = return_value + '0';
            }
        while(octal > 0){
            return_value = (char)((octal & 7) + '0') + return_value;
            octal = octal >> 3;
        }
        return return_value;
    }

    /**
     * Convert a String containing ASCII characters representing a number in
     * hex into a String containing ASCII characters that represent that same
     * value in binary.
     *
     * The output string should only contain numbers.
     * You do not need to handle negative numbers.
     * The length of all the hex strings passed in will be of size 8.
     * The binary string returned should contain 32 characters.
     *
     * Example: hexStringToBinaryString("06A1E4C0"); // => 00000110101000011110010011000000
     *
     * You may declare one String variable in this method.
     */
    public static String hexStringToBinaryString(String hex)
    {
        String return_value = "";
        int toAdd = 0;
        int bit_mask = 15;
        int starting = 0;
        char fourth;
        char third;
        char second;
        char first;
        int count = hex.length();
        for(int i = 0; i < hex.length(); i++){
            if (hex.charAt(i) >= 'A' & hex.charAt(i) <= 'F'){
                toAdd = ((int)(hex.charAt(i) - 'A'+10) & 15); //'B' --> 11
            } else {
                toAdd = ((int)(hex.charAt(i) - '0') & 15);
            }
            fourth = (char)(((int)toAdd & 1) + '0');
            toAdd = toAdd >> 1;
            third = (char)(((int)toAdd & 1) + '0');
            toAdd = toAdd >> 1;
            second = (char)(((int)toAdd & 1) + '0');
            toAdd = toAdd >> 1;
            first = (char)(((int)toAdd & 1) + '0');
            return_value = return_value + first;
            return_value = return_value + second;
            return_value = return_value + third;
            return_value = return_value + fourth;
            count --;
        }
        return return_value;
    }
}
