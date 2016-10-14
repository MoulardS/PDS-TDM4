#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>


void  mcat(const char *path){

    int nbline;
    int buffer_size;
    char *buffer;
    int fd;

    buffer_size=atoi(getenv("MCAT_BUFSIZ"));
    buffer = malloc(buffer_size);
    fd = open(path,O_RDONLY);

    while ((nbline = read(fd,buffer,buffer_size))>0){

        if ((write(1,buffer,buffer_size))<0){

            perror("ERROR : write");
            exit(EXIT_FAILURE);

        }

    }    

    free(buffer);
    close(fd);
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
