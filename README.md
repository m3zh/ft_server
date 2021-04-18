# FT_SERVER on LINUX 🐳

## Docker commands

```
    docker ps -a # shows all containers, their ids, names,...
    docker images # shows all images
    docker container stop <id>
    docker container rm <id>
    docker container prune # remove all stopped containers
    docker image prune # remove all images of stopped containers
    docker build . # build your image (whose id is shown on the last line after a successful built)
    docker run -p 80:80 -p 443:443 <image_id> # -p stands for ports
    docker run -it -p 80:80 -p 443:443 <image_id> # -it stands for interactive
    docker exec -it <container_name> /bin/bash # to open docker in bash mode and see what's inside the container
    docker run exec <container_name> bash /somescript.sh # to run a script inside the container when it is already running,
                                                         without stopping it [NB: the script.sh must be already inside the container, look up COPY command]
```

## Errors and solutions:

1. `Permission denied while trying to connect to the Docker daemon socket at unix`

```
    sudo groupadd docker
    sudo usermod -aG docker ${USER}
    su ${USER}
    docker run hello-world #(to check if it's ok)
```

2. `The container name ... is already in use by container "xxx". You have to remove (or rename) that container to be able to reuse that name.`

```
    docker rm -fv $(docker ps -aq)
```

3. `Error starting userland proxy: listen tcp4 0.0.0.0:80: bind: address already in use.`

```
    sudo lsof -i -P -n | grep <port_number> # i.e. numbers after the :, in this case 80
    sudo kill -9 <process id> #pid is the number in the second column
```

4. `The command '/bin/sh -c ...' returned a non-zero code: 127`  
  
  It means docker didn't find a file or a folder.
  Never use sudo inside docker.
  When you copy a file in the current directory, in docker you need ./, not simply .
  For example, change
```
  COPY bash srcs/myfile.sh .
  RUN sudo bash myfile.sh
```
 in
```
  COPY bash srcs/myfile.sh ./
  RUN bash myfile.sh
```
  Remember that the folder srcs is NOT in your docker container, unless you copy it into the container first.  

5. `E: Unsupported file /xxx given on commandline`  

  Possible causes:  
  You left an unwanted \ in the line preceding this command  
  Your file extension is not corrected (for example you're doing bash for a file who is not .sh)  
  There is a typoo inside your file

## How to run this specific docker container

```
  docker build .
  docker run -p 80:80 -p 443:443 <image_id> # to stop it, run docker container stop <id> in a new terminal
  docker run -it -p 80:80 -p 443:443 <image_id> # to stop it, press ctrl+D
  docker run exec <container_name> bash /autoindex_off.sh # if autoindex is off, your localhost will throw an error "Not found" (usually 403 forbidden)
```
