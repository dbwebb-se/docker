#!/usr/bin/env make
#
# Docker containers for dbwebb related stuff.
# See repo on GitHub: https://github.com/dbwebb-se/docker
# See organisation on Docker: https://hub.docker.com/r/dbwebb


# ------------------------------------------------------------------------
#
# General stuff, reusable for all Makefiles.
#

# Detect OS
OS = $(shell uname -s)

# Defaults
ECHO = echo

# Make adjustments based on OS
ifneq (, $(findstring CYGWIN, $(OS)))
	ECHO = /bin/echo -e
endif

# Colors and helptext
NO_COLOR	= \033[0m
ACTION		= \033[32;01m
OK_COLOR	= \033[32;01m
ERROR_COLOR	= \033[31;01m
WARN_COLOR	= \033[33;01m

# Print out colored action message
ACTION_MESSAGE = $(ECHO) "$(ACTION)---> $(1)$(NO_COLOR)"

# Which makefile am I in?
WHERE-AM-I = $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
THIS_MAKEFILE := $(call WHERE-AM-I)

# Echo some nice helptext based on the target comment
HELPTEXT = $(call ACTION_MESSAGE, $(shell egrep "^\# target: $(1) " $(THIS_MAKEFILE) | sed "s/\# target: $(1)[ ]*-[ ]* / /g"))

# Check version  and path to command and display on one line
CHECK_VERSION = printf "%-15s %-10s %s\n" "`basename $(1)`" "`$(1) --version $(2)`" "`which $(1)`"

# Get current working directory, it may not exist as environment variable.
PWD = $(shell pwd)

# target: help                    - Displays help.
.PHONY:  help
help:
	@$(call HELPTEXT,$@)
	@sed '/^$$/q' $(THIS_MAKEFILE) | tail +3 | sed 's/#\s*//g'
	@$(ECHO) "Usage:"
	@$(ECHO) " make [target] ..."
	@$(ECHO) "target:"
	@egrep "^# target:" $(THIS_MAKEFILE) | sed 's/# target: / /g'



# ------------------------------------------------------------------------
#
# Specifics for this project.
#
D  := docker
DC := docker-compose


# target: update                  - Create the Dockerfiles from source.
.PHONY: update
update:
	@$(call HELPTEXT,$@)
	./update.bash



# target: build                   - Build the docker images.
.PHONY: build
build: update
	@$(call HELPTEXT,$@)
	$(D) build --file $(options) courserepo/debian/Dockerfile.jessie	\
		--tag dbwebb/courserepo:jessie									\
		--tag dbwebb/courserepo:debian-jessie							\
		courserepo/debian
	$(D) build --file $(options) courserepo/debian/Dockerfile.stretch	\
		--tag dbwebb/courserepo:debian									\
		--tag dbwebb/courserepo:stretch									\
		--tag dbwebb/courserepo:debian-stretch							\
		courserepo/debian
	$(D) build --file $(options) courserepo/debian/Dockerfile.buster	\
		--tag dbwebb/courserepo:buster									\
		--tag dbwebb/courserepo:debian-buster							\
		courserepo/debian

	$(D) build --file $(options) 							\
		courserepo/debian/Dockerfile.base					\
		--tag dbwebb/courserepo:base						\
		--tag dbwebb/courserepo:base-debian					\
		courserepo/debian
	$(D) build --file $(options) 							\
	 	courserepo/debian/Dockerfile.base-node				\
		--tag dbwebb/courserepo:base-node					\
		--tag dbwebb/courserepo:base-debian-node			\
		courserepo/debian
	$(D) build --file $(options) 							\
		courserepo/debian/Dockerfile.base-node-python		\
		--tag dbwebb/courserepo:base-python					\
		--tag dbwebb/courserepo:base-node-python			\
		--tag dbwebb/courserepo:base-debian-node-python		\
		courserepo/debian
	$(D) build --file $(options) 							\
		courserepo/debian/Dockerfile.base-node-php			\
		--tag dbwebb/courserepo:base-php					\
		--tag dbwebb/courserepo:base-node-php				\
		--tag dbwebb/courserepo:base-debian-node-php		\
		courserepo/debian
	$(D) build --file $(options) 							\
		courserepo/debian/Dockerfile.base-apache-php		\
		--tag dbwebb/courserepo:base-apache					\
		--tag dbwebb/courserepo:base-apache-php				\
		--tag dbwebb/courserepo:base-debian-apache-php		\
		courserepo/debian
	$(D) build --file $(options) 							\
		courserepo/debian/Dockerfile.base-all				\
		--tag dbwebb/courserepo:all							\
		--tag dbwebb/courserepo:base-all					\
		--tag dbwebb/courserepo:base-debian-all				\
		courserepo/debian

	$(D) build --file $(options) 							\
		courserepo/debian/Dockerfile.course					\
		--tag dbwebb/courserepo:latest						\
		--tag dbwebb/courserepo:course						\
		--tag dbwebb/courserepo:course-debian				\
		courserepo/debian


# target: push                    - Push the docker images to Docker cloud.
.PHONY: push
push:
	@$(call HELPTEXT,$@)
	$(D) push dbwebb/courserepo:debian
	$(D) push dbwebb/courserepo:jessie
	$(D) push dbwebb/courserepo:debian-jessie
	$(D) push dbwebb/courserepo:stretch
	$(D) push dbwebb/courserepo:debian-stretch
	$(D) push dbwebb/courserepo:buster
	$(D) push dbwebb/courserepo:debian-buster

	$(D) push dbwebb/courserepo:base
	$(D) push dbwebb/courserepo:base-debian
	$(D) push dbwebb/courserepo:base-node
	$(D) push dbwebb/courserepo:base-debian-node
	$(D) push dbwebb/courserepo:base-python
	$(D) push dbwebb/courserepo:base-node-python
	$(D) push dbwebb/courserepo:base-debian-node-python
	$(D) push dbwebb/courserepo:base-php
	$(D) push dbwebb/courserepo:base-node-php
	$(D) push dbwebb/courserepo:base-debian-node-php
	$(D) push dbwebb/courserepo:base-apache
	$(D) push dbwebb/courserepo:base-apache-php
	$(D) push dbwebb/courserepo:base-debian-apache-php
	$(D) push dbwebb/courserepo:all
	$(D) push dbwebb/courserepo:base-all
	$(D) push dbwebb/courserepo:base-debian-all

	$(D) push dbwebb/courserepo:latest
	$(D) push dbwebb/courserepo:course
	$(D) push dbwebb/courserepo:course-debian
