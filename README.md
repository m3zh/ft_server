# FT_SERVER on LINUX

Errors you might stumble upon and my solutions:

1. permission denied while trying to connect to the Docker daemon socket at unix 
    sudo groupadd docker
    sudo usermod -aG docker ${USER}
    su ${USER}
    docker run hello-world #(to check if it's ok)

2. The container name ... is already in use by container "xxx". You have to remove (or rename) that container to be able to reuse that name.
    docker rm -fv $(docker ps -aq)

3. Error starting userland proxy: listen tcp4 0.0.0.0:80: bind: address already in use.
    sudo lsof -i -P -n | grep <port_number> #i.e. numbers after the :, in this case 80
    sudo kill -9 <process id> #pid is the number in the second column

4. The command '/bin/sh -c ...' returned a non-zero code: 127
It means docker didn't find a file or a folder.
Never use sudo inside docker.
When you copy a file in the current directory, in docker you need ./, not simply .
For example, change
COPY bash srcs/myfile.sh .
RUN sudo bash myfile.sh
in 
COPY bash srcs/myfile.sh ./
RUN bash myfile.sh
