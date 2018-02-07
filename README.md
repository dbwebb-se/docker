Docker for dbwebb
====================

Docker images for running, testing, developing and inspecting dbwebb related.

Images are published on [Docker Store on the dbwebb organisation](https://hub.docker.com/r/dbwebb).



Development of images
-------------------

Use docker-compose to try out and test the various images. See `docker-compose.yml` for the collection of images.

```text
docker-compose up php71-apache
```

Use makefile to build and push images.

```text
make build
make push
```



Acknowledgement
-------------------

This is a co-effort of several people using freely available documentation and tools from the open source community.

For contributors, see commit history and issues.

Feel free to help building up the repository with more content suited for training and education.



```
 .
..:  Copyright (c) 2017-2018 dbwebb et al, info@dbwebb.se
```
