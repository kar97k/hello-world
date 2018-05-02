#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern void correct_string(char* str);

int main(void) {

char str[256];

printf("Input string:\n");

if (fgets(str, sizeof(str), stdin) != str) {
    printf("Error\n");
    return 1;
}

printf("Addr of first symbol:\n%p\n------------------------------\n", str);

correct_string(str);

return 0;
}
