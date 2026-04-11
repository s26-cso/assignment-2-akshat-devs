#include <stdio.h>
#include <string.h>
#include <dlfcn.h>

typedef int (*fptr)(int, int);

int main() {

    char op[6];
    int a, b;

    while (scanf("%s %d %d", op, &a, &b) == 3) {
        char libname[12];
        snprintf(libname, sizeof(libname), "./lib%s.so", op);

        void* handle = dlopen(libname, RTLD_LAZY);
        fptr operation = dlsym(handle, op);
        int result = operation(a, b);
        printf("%d\n", result);
        dlclose(handle);
    }

    return 0;
}
