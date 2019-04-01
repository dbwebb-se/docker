#!/usr/bin/env bash

# Base images
debian="src/baseimage_debian"

# Dockerfiles for debian
for version in jessie stretch buster; do
    lib="courserepo/debian"
    target="$lib/Dockerfile.$version"

    cat \
        src/autogenerated \
        src/baseimage_debian-${version} \
        src/debian_base \
        src/workdir \
        > $target
    echo "Created $target"
done



# Dockerfiles for course repo base
lib="courserepo/debian"
target="$lib/Dockerfile.base"

cat \
    src/autogenerated \
    $debian \
    src/local_user \
    > $target
echo "Created $target"



# Dockerfiles for course repo base with node
lib="courserepo/debian"
target="$lib/Dockerfile.base-node"

cat \
    src/autogenerated \
    $debian \
    src/node_10 \
    src/local_user \
    > $target
echo "Created $target"



# Dockerfiles for course repo base with node and python
lib="courserepo/debian"
target="$lib/Dockerfile.base-node-python"

cat \
    src/autogenerated \
    $debian \
    src/node_10 \
    src/python \
    src/local_user \
    > $target
echo "Created $target"



# Dockerfiles for course repo base with node and PHP
lib="courserepo/debian"
target="$lib/Dockerfile.base-node-php"

cat \
    src/autogenerated \
    $debian \
    src/node_10 \
    src/php_73_cli \
    src/php_xdebug \
    src/php_ini_error_reporting \
    src/composer \
    src/local_user \
    > $target
echo "Created $target"
#src/php_ini_opcache \



# Dockerfiles for course repo base with Apache and PHP
lib="courserepo/debian"
target="$lib/Dockerfile.base-apache-php"

cp src/apache.conf $lib
cat \
    src/autogenerated \
    $debian \
    src/apache \
    src/php_73_cli \
    src/php_73_apache \
    src/php_xdebug \
    src/php_ini_error_reporting \
    src/composer \
    > $target
echo "Created $target"
#src/php_ini_opcache \



# Dockerfiles for course repo, all utilities together (withouth apache)
lib="courserepo/debian"
target="$lib/Dockerfile.base-all-cli"

cp src/apache.conf $lib
cat \
    src/autogenerated \
    $debian \
    src/mysql-client \
    src/node_10 \
    src/python \
    src/php_73_cli \
    src/php_xdebug \
    src/php_ini_error_reporting \
    src/composer \
    src/dbwebb_cli \
    > $target
echo "Created $target"
#src/php_ini_opcache \



# Dockerfiles for course repo, all utilities together
lib="courserepo/debian"
target="$lib/Dockerfile.base-all"

cp src/apache.conf $lib
cat \
    src/autogenerated \
    $debian \
    src/mysql-client \
    src/node_10 \
    src/python \
    src/apache \
    src/php_73_cli \
    src/php_73_apache \
    src/php_xdebug \
    src/php_ini_error_reporting \
    src/composer \
    src/dbwebb_cli \
    > $target
echo "Created $target"
#src/php_ini_opcache \



# Dockerfiles for course repo, all included except apache
lib="courserepo/debian"
target="$lib/Dockerfile.course-cli"

cp src/apache.conf $lib
cat \
    src/autogenerated \
    src/baseimage_base-all-cli \
    src/local_user \
    src/dbwebb_cli_config \
    src/git_config \
    > $target
echo "Created $target"



# Dockerfiles for course repo, all included
lib="courserepo/debian"
target="$lib/Dockerfile.course"

cp src/apache.conf $lib
cat \
    src/autogenerated \
    src/baseimage_base-all \
    src/local_user \
    src/dbwebb_cli_config \
    src/git_config \
    src/user_as_root \
    > $target
echo "Created $target"



# Dockerfiles for course repo, with tools installed
# Send course name as ARG, change this later on to get a
# hard printout of the dockerfile used, better for doumentation.
lib="courserepo/debian"
target="$lib/Dockerfile.course-make-install-npm"

cp src/apache.conf $lib
cat \
    src/autogenerated \
    src/baseimage_course \
    src/make_install_npm \
    > $target
echo "Created $target"



# Dockerfiles for course repo, cli, including ctf utilities
lib="courserepo/debian"
target="$lib/Dockerfile.course-ctf-cli"

cat \
    src/autogenerated \
    src/baseimage_base-all-cli \
    src/debian_ctf_utilities \
    src/local_user \
    src/dbwebb_cli_config \
    src/git_config \
    > $target
echo "Created $target"



# Dockerfiles for course repo, apache, including ctf utilities
lib="courserepo/debian"
target="$lib/Dockerfile.course-ctf-apache"

cp src/apache.conf $lib
cat \
    src/autogenerated \
    src/baseimage_base-all \
    src/debian_ctf_utilities \
    src/local_user \
    src/dbwebb_cli_config \
    src/git_config \
    src/user_as_root \
    > $target
echo "Created $target"
