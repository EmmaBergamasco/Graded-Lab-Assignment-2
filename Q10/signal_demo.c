vi signal_demo.c  #create signal_demo.c using vi editor
i  #insert mode

#include <stdio.h>      // for printf()
#include <stdlib.h>     // for exit()
#include <unistd.h>     // for fork(), sleep(), getpid()
#include <signal.h>     // for signal handling
#include <sys/types.h>  // for pid_t
#include <sys/wait.h>   // for wait()

void handle_sigterm(int sig) {
    printf("Parent received SIGTERM (signal %d). Ignoring and continuing...\n", sig); //print message but do not terminate parent
}

// Signal handler for SIGINT
void handle_sigint(int sig) {
    printf("Parent received SIGINT (signal %d). Exiting gracefully.\n", sig);  //print message
    exit(0);  //exit parent process
}

int main() {
    signal(SIGTERM, handle_sigterm);  
    signal(SIGINT, handle_sigint);  //associates each signal with its handler 

    pid_t pid1 = fork();  //create first child to send SIGTERM
    if (pid1 == 0) {  
        sleep(5);  //wait 5 seconds
        kill(getppid(), SIGTERM);  //send SIGTERM to parent
        exit(0);  //terminate child
    }

    pid_t pid2 = fork(); //create second child to send SIGINT
    if (pid2 == 0) { 
        sleep(10);  //wait 10 seconds
        kill(getppid(), SIGINT);  //send SIGINT to parent
        exit(0);  //terminate child
    }

    printf("Parent PID: %d running. Waiting for signals...\n", getpid());
    while (1) {
        pause();  //suspend execution whule waiting for signal
    }

    return 0;  
}

Esc  #exit insert mode
:wq  #save and quit
