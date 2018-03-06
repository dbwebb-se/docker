Docker for dbwebb course repo
-------------------

Docker images for working with course repos.

The organisation dbwebb resides in the [dbwebb organisation on GitHub](https://github.com/dbwebb-se).



Supported tags and respective Dockerfile links
-------------------

* [`course-databas`, `databas` (courserepo/debian/Dockerfile.course-make-install-npm)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.course-make-install-npm)
* [`course-debian`, `course`, `latest` (courserepo/debian/Dockerfile.course)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.course)
* [`base-debian-all`, `base-all`, `all`  (courserepo/debian/Dockerfile.base-all)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.base-all)
* [`base-debian-apache-php`, `base-apache-php`, `base-apache`  (courserepo/debian/Dockerfile.base-apache-php)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.base-apache-php)
* [`base-debian-node-php`, `base-node-php`, `base-php`  (courserepo/debian/Dockerfile.base-node-php)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.base-node-php)
* [`base-debian-node-python`, `base-node-python`, `base-python`  (courserepo/debian/Dockerfile.base-node-python)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.base-node-python)
* [`base-debian-node`, `base-node`  (courserepo/debian/Dockerfile.base-node)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.base-node)
* [`base-debian`, `base` (courserepo/debian/Dockerfile.base)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.base)
* [`debian-buster`, `buster`  (courserepo/debian/Dockerfile.buster)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.buster)
* [`debian-stretch`, `stretch`, `debian` (courserepo/debian/Dockerfile.stretch)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.stretch)
* [`debian-jessie`, `jessie` (courserepo/debian/Dockerfile.jessie)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.jessie)



Quick reference
-------------------

* Where to get help:
    https://github.com/dbwebb-se/docker/issues

* Where to file issues:
    https://github.com/dbwebb-se/docker/issues

* Maintained by:
    [dbwebb organisation and community](https://github.com/dbwebb-se/docker/issues)

* Source of this description:
    [doc/courserepo/README.md](https://github.com/dbwebb-se/docker/blob/master/doc/courserepo/README.md)



How to use this image
-------------------



### With course repo Makefile

The Makefile in the courserepo has support for running docker related commands. Execute `make` and see all commands starting with `docker-`.



### With docker-compose

Create a `docker-compose.yml`. The course repo should contain such a file.

```text
version: "3"
services:
    course-databas:
        image: dbwebb/courserepo:databas
        volumes: [ ".:/home/dbwebb/repo" ]
        ports: [ "10042:80" ]
    course:
        image: dbwebb/courserepo
        volumes: [ ".:/home/dbwebb/repo" ]
        ports: [ "10042:80" ]
    base-all:
        image: dbwebb/courserepo:base-all
        volumes: [ ".:/home/dbwebb/repo" ]
        ports: [ "10042:80" ]
    base-apache:
        image: dbwebb/courserepo:base-apache
        volumes: [ ".:/home/dbwebb/repo" ]
        ports: [ "10042:80" ]
    base-php:
        image: dbwebb/courserepo:base-php
        volumes: [ ".:/home/dbwebb/repo" ]
    base-python:
        image: dbwebb/courserepo:base-python
        volumes: [ ".:/home/dbwebb/repo" ]
    base-node:
        image: dbwebb/courserepo:base-node
        volumes: [ ".:/home/dbwebb/repo" ]
    base:
        image: dbwebb/courserepo:base
        volumes: [ ".:/home/dbwebb/repo" ]
    jessie:
        image: dbwebb/courserepo:jessie
        volumes: [ ".:/home/dbwebb/repo" ]
    stretch:
        image: dbwebb/courserepo:stretch
        volumes: [ ".:/home/dbwebb/repo" ]
    buster:
        image: dbwebb/courserepo:buster
        volumes: [ ".:/home/dbwebb/repo" ]
```

Your current directory (the course repo) will be mounted onto the container, excluding those directories listed, which are part of the image itself.

Start the container in the background.

```text
docker-compose up -d course
```

Open a browser to localhost:10042.

Run a bash terminal on the running container.

```text
docker-compose exec course bash
```

Shut down the container.

```text
docker-compose down
```

Run a one off command using another container.

```text
docker-compose run course bash
```



License
-------------------

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.



Acknowledgement
-------------------

This is a co-effort of several people using freely available documentation and tools from the open source community.

For contributors, see commit history and issues.




```
 .
..:  Copyright (c) 2017-2018 dbwebb et al, info@dbwebb.se
```
