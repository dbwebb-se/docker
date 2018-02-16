Docker for dbwebb courserepo
-------------------

Docker images for working with courserepos.

The organisation dbwebb resides in the [dbwebb organisation on GitHub](https://github.com/dbwebb-se).



Supported tags and respective Dockerfile links
-------------------

* [`course`, `latest` (courserepo/debian/Dockerfile.course)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.course)
* [`base` (courserepo/debian/Dockerfile.base)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.base)



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
    course:
        image: dbwebb/courserepo
        ports:
            - "10080:80"
        volumes:
            - ./:/dbwebb-kurs/
            - /dbwebb-kurs/bin/
            - /dbwebb-kurs/build/
            - /dbwebb-kurs/example/utility/
            - /dbwebb-kurs/node_modules/
            - /dbwebb-kurs/vendor/
```

Your current directory will be mounted onto the container, excluding those directories listed, which are part of the image itself.

Start the container in the background.

```text
docker-compose up -d
```

Open a browser to localhost:10080.

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
