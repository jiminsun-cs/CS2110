/**
 * @file my_string.c
 * @author Jimin Sun
 * @brief Your implementation of these famous 3 string.h library functions!
 *
 * NOTE: NO ARRAY NOTATION IS ALLOWED IN THIS FILE
 *
 * @date 2021-03-22
 */

// DO NOT MODIFY THE INCLUDE(s) LIST
#include <stddef.h>
#include "hw7.h"

/**
 * @brief Calculate the length of a string
 *
 * @param s a constant C string
 * @return size_t the number of characters in the passed in string
 */
size_t my_strlen(const char *s)
{
    UNUSED_PARAM(s);
    int strlen = 0;
    int i = 0;
    char start = *s ; //start holds value @ address
    while (start != 0) { // while it still contains value
        i = i + 1;
        start = *(s + i); //go to address, add one, get value! if value is 0 then end
        strlen = strlen + 1;
    }

    return strlen;
}

/**
 * @brief Compare two strings
 *
 * @param s1 First string to be compared
 * @param s2 Second string to be compared
 * @param n First (at most) n bytes to be compared
 * @return int "less than, equal to, or greater than zero if s1 (or the first n
 * bytes thereof) is found, respectively, to be less than, to match, or be
 * greater than s2"
 */
int my_strncmp(const char *s1, const char *s2, size_t n)
{
    for (size_t i = 0; i < n; i++) {
//        if (*(s1 + i) == 0 || *(s2 + i) == 0) {
//            break;
//        }
        if ((*(s1 + i) - *(s2 + i)) == 0){
            continue;
        } else {
            return (*(s1 + i) - *(s2 + i));
        }
    }
    return  0;
}

/**
 * @brief Copy a string
 *
 * @param dest The destination buffer
 * @param src The source to copy from
 * @param n maximum number of bytes to copy
 * @return char* a pointer same as dest
 */
char *my_strncpy(char *dest, const char *src, size_t n)
{
    UNUSED_PARAM(dest);
    UNUSED_PARAM(src);
    UNUSED_PARAM(n);
    // char *p = &i ; saves address of i to p
    for (size_t i = 0; i < n; i++) {
        *(dest + i) = *(src + i);
    }
    return dest;
}
