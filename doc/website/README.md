Docker for dbwebb website repo
-------------------

Docker images for working with dbwebb website repo.

The organisation dbwebb resides in the [dbwebb organisation on GitHub](https://github.com/dbwebb-se).



Supported tags and respective Dockerfile links
-------------------

The repo for the website, pre installed in the docker image.

* [`all`, `latest` (website/Dockerfile.website)](https://github.com/dbwebb-se/docker/blob/master/website/Dockerfile.website)



Quick reference
-------------------

* Where to get help:
    https://github.com/dbwebb-se/docker/issues

* Where to file issues:
    https://github.com/dbwebb-se/docker/issues

* Maintained by:
    [dbwebb organisation and community](https://github.com/dbwebb-se/docker/issues)

* Source of this description:
    [doc/website/README.md](https://github.com/dbwebb-se/docker/blob/master/doc/website/README.md)



How to use this image
-------------------



### With docker-compose

Create a `docker-compose.yml`. The course repo should contain such a file.

```text
version: "3"
services:
    website: &website
        image: dbwebb/website:all
        ports:
            - "8080:80"
        volumes:
            # Mount these from your cloned repo
            - .:/app
            - ./config/docker/dbwebb.se.conf:/etc/apache2/sites-enabled/000-default.conf

            # Do not mount these, use the ones exiting in the container
            - /app/vendor
    cli:
        image: dbwebb/website:all
        volumes:
            - .:/home/anax/repo
```

Your current directory (the repo) will be mounted onto the container to `/app`, excluding those directories listed, which are then to be part of the image itself.

Start the container in (the background).

```text
docker-compose up website
docker-compose up -d website
```

Open a browser to localhost:8080 to display the website.

Run a bash terminal on the running container.

```text
docker-compose exec website bash
```

Shut down the container.

```text
docker-compose down
```

Run a one off command using the cli container.

```text
docker-compose run cli bash
```

You can also run this container directly using docker and mounting its port to a port of your own choice.

```text
docker run -p 8080:80 dbwebb/website
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
..:  Copyright (c) 2017-2020 Mikael Roos, mos@dbwebb.se
```
