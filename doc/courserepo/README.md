Docker for dbwebb courserepo
-------------------

Docker images for working with courserepos.

The organisation dbwebb resides in the [dbwebb organisation on GitHub](https://github.com/dbwebb-se).



Supported tags and respective Dockerfile links
-------------------

* [`base` (courserepo/debian/Dockerfile.base)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.base)
* [`databas` (courserepo/debian/Dockerfile.course)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.course)
* [`oopython` (courserepo/debian/Dockerfile.course)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.course)
* [`linux` (courserepo/debian/Dockerfile.course)](https://github.com/dbwebb-se/docker/blob/master/courserepo/debian/Dockerfile.course)



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



### With docker-compose

Create a `docker-compose.yml` with a service "website" using this image.

```text
version: "3"
services:
    databas:
        image: dbwebb/courserepo:databas
        ports:
            - "8080:80"
```

Use a volume to mount your project directory into the image.

Use a volume to provide a apache virtual host as a base for the default host in the webserver.

The virtual host can/should point out the document root to use. Usually this is `./htdocs` for Anax, or `/app/htdocs` within the container.

Create a directory `log` where apache will write its logs.

Start the container in the background.

```text
docker-compose up -d website
```

Open a browser to localhost:8080.

Run a bash terminal on the container.

```text
docker-compose exec website bash
```

Shut down the container.

```text
docker-compose down website
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
