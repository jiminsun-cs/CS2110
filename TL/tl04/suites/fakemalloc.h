#include <stdlib.h>

#define malloc(n)    ((mallocs_until_fail == -1 || (mallocs_until_fail && mallocs_until_fail--)) ? malloc(n)    : NULL)
#define calloc(n,s)  ((mallocs_until_fail == -1 || (mallocs_until_fail && mallocs_until_fail--)) ? calloc(n,s)  : NULL)
#define realloc(n,s) ((mallocs_until_fail == -1 || (mallocs_until_fail && mallocs_until_fail--)) ? realloc(n,s) : NULL)

extern int mallocs_until_fail;
