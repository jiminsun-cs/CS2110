/**
 * @file hw7.c
 * @author YOUR NAME HERE
 * @brief structs, pointers, pointer arithmetic, arrays, strings, and macros
 * @date 2021-03-xx
 */

// DO NOT MODIFY THE INCLUDE(S) LIST
#include <stdio.h>
#include "hw7.h"
#include "my_string.h"

// Global array of student structs
struct student class[MAX_CLASS_SIZE];

int size = 0;

/** addStudent
 *
 * @brief creates a new student struct and adds it to the array of student structs, "class"
 *
 *
 * @param "name" name of the student being created and added
 *               NOTE: if the length of name (including the null terminating character)
 *               is above MAX_NAME_SIZE, truncate name to MAX_NAME_SIZE
 * @param "age" age of the student being created and added
 * @param "gpa" gpa of the student being created and added
 * @param "id" id of the student being created and added
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) the length of "id" is less than MIN_ID_SIZE
 *         (2) a student with the name "name" already exits in the array "class"
 *         (3) adding the new student would cause the size of the array "class" to
 *             exceed MAX_CLASS_SIZE
 */
int addStudent(const char *name, int age, double gpa, const char *id)
{
  if (my_strlen(name) + 1 > MAX_NAME_SIZE) {
    my_strncpy(class[size].name, name, MAX_NAME_SIZE - 1); // add null terminator
    class[size].name[MAX_NAME_SIZE - 1] = 0;
    } else {
    my_strncpy(class[size].name, name, my_strlen(name));
    class[size].name[my_strlen(name)] = 0;
    }

    //*         (1) the length of "id" is less than MIN_ID_SIZE
    if (my_strlen(id) + 1 < MIN_ID_SIZE) {
        return FAILURE;
    }
// *         (2) a student with the name "name" already exits in the array "class"
    int i = 0;
    while (i < size) { // while current is in array
        if (my_strncmp(class[i].name, name, my_strlen(name)) == 0) {
            return FAILURE;
        }
        i = i + 1;
    }
// *         (3) adding the new student would cause the size of the array "class" to
// *             exceed MAX_CLASS_SIZE
    if (size + 1 > MAX_CLASS_SIZE) {
        return FAILURE;
    }
    my_strncpy(class[size].id, id, my_strlen(id));
    class[size].id[my_strlen(id)] = 0;
    class[size].gpa = gpa;
    class[size].age = age;
    size = size + 1;
    return SUCCESS;
}

/** updateStudentName
 *
 * @brief updates the name of an existing student in the array of student structs, "class"
 *
 * @param "s" student struct that exists in the array "class"
 * @param "name" new name of student "s"
 *               NOTE: if the length of name (including the null terminating character)
 *               is above MAX_NAME_SIZE, truncate name to MAX_NAME_SIZE
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) the student struct "s" can not be found in the array "class"
 */
int updateStudentName(struct student s, const char *name)
{
  UNUSED_PARAM(s);
  UNUSED_PARAM(name);

// check if name is in array
    int i = 0;
    int final = 0;
    while (i < size) { // while current is in array
        if (my_strncmp(class[i].name, s.name, my_strlen(s.name)) == 0) {
            final = final + 1;
        }
        i = i + 1;
    }

    if (final == 0) {
        return FAILURE;
    } else {
        int idx = 0;
        while (my_strncmp(class[idx].name, s.name, my_strlen(s.name)) != 0) {
            idx = idx + 1;
        }
        // idx = where name is
        if (my_strlen(name) + 1 > MAX_NAME_SIZE) {
         my_strncpy(class[idx].name, name, MAX_NAME_SIZE - 1); // add null terminator
         class[idx].name[MAX_NAME_SIZE - 1] = 0;
         } else {
         my_strncpy(class[idx].name, name, my_strlen(name));
         class[idx].name[my_strlen(name)] = 0;
        }
    return SUCCESS;
    }
}

/** swapStudents
 *
 * @brief swaps the position of two student structs in the array of student structs, "class"
 *
 * @param "index1" index of the first student struct in the array "class"
 * @param "index2" index of the second student struct in the array "class"
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) "index1" and/or "index2" are negative numbers
 *         (2) "index1" and/or "index2" are out of bounds of the array "class"
 */
int swapStudents(int index1, int index2)
{
  if (index1  < 0 || index2 < 0){
    return FAILURE;
  } else if (index1 >= size || index2 >= size) {
    return FAILURE;
  } else {
    struct student temp;
    temp = class[index1]; //temp stores value of index1
    class[index1] = class[index2];
    class[index2] = temp;
    return SUCCESS;
  }
}

/** removeStudent
 *
 * @brief removes an existing student in the array of student structs, "class"
 *
 * @param "s" student struct that exists in the array "class"
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) the student struct "s" can not be found in the array "class"
 */
int removeStudent(struct student s)
{
  UNUSED_PARAM(s);
    int i = 0;
    int final = 0;
    while (i < size) { // while current is in array
        if (my_strncmp(class[i].name, s.name, my_strlen(s.name)) == 0) {
            final = final + 1;
        }
    i = i + 1;
    }

    if (final == 0){
        return FAILURE;
    } else {
        int idx = 0;
        while (my_strncmp(class[idx].name, s.name, my_strlen(s.name)) != 0) {
            idx = idx + 1;
        }
        // idx = inex of where s is.
        for(int j = 0; j < size - idx; j++)  {
            swapStudents(idx + j, idx + j + 1);
        }
        size = size - 1;
        return SUCCESS;
    }

}

/** compareStudentID
 *
 * @brief using ASCII, compares the last three characters (not including the NULL
 * terminating character) of two students' IDs
 *
 * @param "s1" student struct that exists in the array "class"
 * @param "s2" student struct that exists in the array "class"
 * @return negative number if s1 is less than s2, positive number if s1 is greater
 *         than s2, and 0 if s1 is equal to s2
 */
int compareStudentID(struct student s1, struct student s2)
{
  int len1 = my_strlen(s1.id);
  int len2 = my_strlen(s2.id); // 01234 --> len = 5 , want to index from 2.
  int idx1 = len1 - 3; // where to start to compare last three
  int idx2 = len2 - 3;
  char *id1 = (s1.id); //instantiates a char pointer id1 which points to the first element of s1.id.
  char *id2 = (s2.id);
  for (int i = 0; i < 3; i++) {
      if ((*(id1 + idx1 + i) - *(id2 + idx2 + i)) == 0){
          continue;
      } else {
          return (*(id1 + idx1 + i) - *(id2 + idx2 + i));
      }
  }
  return 0;
}

/** sortStudents
 *
 * @brief using the compareStudentID function, sort the students in the array of
 * student structs, "class," by the last three characters of their student IDs
 *
 * @param void
 * @return void
 */
void sortStudents(void)
{
    int y = size - 1;
    while (y > 0) {
        struct student temp;
        int x = 0;
        while (x < y) {
            if (compareStudentID(class[x], class[x+1]) >= 0) {
                temp = class[x];
                class[x] = class[x+1];
                class[x+1] = temp;
            }
            x = x + 1;
        }
        y = y - 1;
    }
}
