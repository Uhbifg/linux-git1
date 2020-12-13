#include <stdio.h> 

int main(int argc, char *argv[]){
    char *sal = "World";
    if (argc>1){
        sal = argv[1];
    }
    printf("Hello, %s!\n",sal);
    return 0;
}
