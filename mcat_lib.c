#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>


void  mcat(const char *path){

    int nbline;
    FILE *f;
    f = fopen(path,"r");

    while ((nbline = fgetc(f)) != EOF){

        fputc(nbline,stdout);


	}

    fclose(f);
}

int main(int argc,char *argv[]){

    int i;

    if(argc < 1) {
        fprintf(stderr, "Argument missing : The correct format of the commande is : ./mcat-scd [FILE] ...");
        exit(EXIT_FAILURE);
    }

    for (i = 1; i < argc; i++) {
        mcat(argv[i]);
    }

    return EXIT_SUCCESS;

}
