#include "qmlshell.h"

#include <string>
#include <utility>
#include <unistd.h>
#include <iostream>
#include <fcntl.h>
#include <poll.h>

QMLShell::QMLShell(QObject *parent)
    : QThread{parent}
{
    _backlog.clear();
}

void QMLShell::buttonPressed(QString inputText)
{
    write(fds.second,(inputText+'\n').toStdString().c_str(),inputText.size()+1);
    //std::cout << "RECV from input -- " << inputText.toStdString() << std::endl;
}

QString QMLShell::text() const
{
    return _backlog;
}

void QMLShell::run()
{
    pid_t pid;
    int ppipe[2];
    int cpipe[2];

    /* Warning: I'm not handling possible errors in pipe/fork */

    pipe2(ppipe,O_CLOEXEC); /* Parent read/child write pipe */
    pipe2(cpipe,O_CLOEXEC); /* Child read/parent write pipe */

    if ((pid = fork()) == 0) {
        //close(ppipe[0]);
        //close(cpipe[1]);

        dup2(ppipe[0],STDIN_FILENO);
        dup2(cpipe[1],STDOUT_FILENO);
        dup2(cpipe[1],STDERR_FILENO);

        execl("/usr/bin/env","env","-iS","/bin/sh -iv +m",nullptr);

        exit(0);
    }

    _backlog += "Started sh on PID: " + QString::number(pid) + "\n";

    fds.first = cpipe[0];
    fds.second = ppipe[1];

    pollfd pfd;
    pfd.fd = fds.first;
    pfd.events = POLLIN;

    while (1)
    {
        poll(&pfd,1,-1);

        if (pfd.revents & POLLIN)
        {
            char buffer[1024];
            auto value = std::string(buffer,read(fds.first,buffer,1024));
            _backlog += value;

            const int MaxBufferSize = 10000;
            if (_backlog.size() > MaxBufferSize)
            {
                _backlog.erase(&_backlog[0], &_backlog[_backlog.size() - MaxBufferSize]);
                std::cout << "Backlog trimmed!" << std::endl;
            }
            sleep(1);

            emit textChanged();
            //std::cout << "RECV from child" << std::endl;
        }
        //std::cout << "> " << std::flush;
    }
}
