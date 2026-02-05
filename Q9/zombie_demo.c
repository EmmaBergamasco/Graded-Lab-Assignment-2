vi zombie_demo.c  #create zombie_demo.c using vi editor
i  #insert mode

#include <stdio.h>      //for printf()
#include <stdlib.h>     //for exit()
#include <sys/types.h>  //for pid_t
#include <sys/wait.h>   //for wait(), waitpid()
#include <unistd.h>     //for fork()

int main() {
    int num_children = 3;  //create 3 child processes for demonstration 
    pid_t pid;

    for (int i = 0; i < num_children; i++) {
        pid = fork();  //create a new child process for every iteration 

        if (pid < 0) {  //if fork fails
            perror("fork failed");  //print error message
            exit(1);  //exit program
        }

        if (pid == 0) {  //child process block
            printf("Child PID: %d started\n", getpid());  //print PID of child process
            sleep(2);  //simulate some work
            printf("Child PID: %d exiting\n", getpid());  //print PID before exit
            exit(0);  //terminate child process
        }

    }

    int status;
    pid_t wpid;
    while ((wpid = wait(&status)) > 0) {  //wait for any child process to terminate
        printf("Parent cleaned up child PID: %d\n", wpid);  //print PID of cleaned child
    }

    printf("All child processes have been cleaned up. No zombies remain.\n");

    return 0;  //parent exits
}

Esc  #exit insert mode
:wq  #save and quit
