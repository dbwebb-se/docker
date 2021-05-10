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
# options = --no-cache



# target: update                  - Create the Dockerfiles from source.
.PHONY: update
update:
	@$(call HELPTEXT,$@)
	./update.bash



# target: build                   - Build the docker images.
.PHONY: build
build: update build-debian build-courserepo build-ctf build-website
	@$(call HELPTEXT,$@)



# target: build-debian            - Build the docker images for debian.
.PHONY: build-debian
build-debian: update
	@$(call HELPTEXT,$@)
	# $(D) build $(options) --file courserepo/debian/Dockerfile.jessie	\
	# 	--tag dbwebb/courserepo:jessie									\
	# 	--tag dbwebb/courserepo:debian-jessie							\
	# 	courserepo/debian
	$(D) build $(options) --file courserepo/debian/Dockerfile.stretch	\
		--tag dbwebb/courserepo:stretch									\
		--tag dbwebb/courserepo:debian-stretch							\
		courserepo/debian
	$(D) build $(options) --file courserepo/debian/Dockerfile.buster	\
		--tag dbwebb/courserepo:debian									\
		--tag dbwebb/courserepo:buster									\
		--tag dbwebb/courserepo:debian-buster							\
		courserepo/debian



# target: build-courserepo        - Build the docker images.
.PHONY: build-courserepo
build-courserepo: update build-debian
	@$(call HELPTEXT,$@)
	$(D) build $(options) --file 							\
		courserepo/debian/Dockerfile.base					\
		--tag dbwebb/courserepo:base						\
		--tag dbwebb/courserepo:base-debian					\
		courserepo/debian
	$(D) build $(options) --file 							\
	 	courserepo/debian/Dockerfile.base-node				\
		--tag dbwebb/courserepo:base-node					\
		--tag dbwebb/courserepo:base-debian-node			\
		courserepo/debian
	$(D) build $(options) --file 							\
		courserepo/debian/Dockerfile.base-node-python		\
		--tag dbwebb/courserepo:base-python					\
		--tag dbwebb/courserepo:base-node-python			\
		--tag dbwebb/courserepo:base-debian-node-python		\
		courserepo/debian
	$(D) build $(options) --file 							\
		courserepo/debian/Dockerfile.base-node-php			\
		--tag dbwebb/courserepo:base-php					\
		--tag dbwebb/courserepo:base-node-php				\
		--tag dbwebb/courserepo:base-debian-node-php		\
		courserepo/debian
	$(D) build $(options) --file 							\
		courserepo/debian/Dockerfile.base-apache-php		\
		--tag dbwebb/courserepo:base-apache					\
		--tag dbwebb/courserepo:base-apache-php				\
		--tag dbwebb/courserepo:base-debian-apache-php		\
		courserepo/debian

	# All as cli only version and one with apache
	$(D) build $(options) --file 							\
		courserepo/debian/Dockerfile.base-all-cli			\
		--tag dbwebb/courserepo:all-cli						\
		--tag dbwebb/courserepo:base-all-cli				\
		--tag dbwebb/courserepo:base-debian-all-cli			\
		courserepo/debian
	$(D) build $(options) --file 							\
		courserepo/debian/Dockerfile.base-all				\
		--tag dbwebb/courserepo:all							\
		--tag dbwebb/courserepo:base-all					\
		--tag dbwebb/courserepo:base-debian-all				\
		courserepo/debian

	# Complete base for course repo with tools, cli or apache
	$(D) build $(options) --file 							\
		courserepo/debian/Dockerfile.course-cli				\
		--tag dbwebb/courserepo:cli							\
		--tag dbwebb/courserepo:course-cli					\
		--tag dbwebb/courserepo:course-debian-cli			\
		courserepo/debian
	$(D) build $(options) --file 							\
		courserepo/debian/Dockerfile.course					\
		--tag dbwebb/courserepo:latest						\
		--tag dbwebb/courserepo:web							\
		--tag dbwebb/courserepo:apache						\
		--tag dbwebb/courserepo:course						\
		--tag dbwebb/courserepo:course-debian				\
		courserepo/debian

	# With installed source for each course repo.
	$(D) build $(options) --file 								\
		courserepo/debian/Dockerfile.course-make-install-npm	\
		--build-arg DBW_COURSE_REPO=htmlphp						\
		--tag dbwebb/courserepo:htmlphp							\
		--tag dbwebb/courserepo:course-htmlphp					\
		courserepo/debian
	$(D) build $(options) --file 								\
		courserepo/debian/Dockerfile.course-make-install-npm	\
		--build-arg DBW_COURSE_REPO=design						\
		--tag dbwebb/courserepo:design							\
		--tag dbwebb/courserepo:course-design					\
		courserepo/debian
	$(D) build $(options) --file 								\
		courserepo/debian/Dockerfile.course-make-install-npm	\
		--build-arg DBW_COURSE_REPO=databas						\
		--tag dbwebb/courserepo:databas							\
		--tag dbwebb/courserepo:course-databas					\
		courserepo/debian
	$(D) build $(options) --file 								\
		courserepo/debian/Dockerfile.course-make-install-npm	\
		--build-arg DBW_COURSE_REPO=oophp						\
		--tag dbwebb/courserepo:oophp							\
		--tag dbwebb/courserepo:course-oophp					\
		courserepo/debian
	$(D) build $(options) --file 								\
		courserepo/debian/Dockerfile.course-make-install-npm	\
		--build-arg DBW_COURSE_REPO=ramverk1					\
		--tag dbwebb/courserepo:ramverk1						\
		--tag dbwebb/courserepo:course-ramverk1					\
		courserepo/debian
	$(D) build $(options) --file 								\
		courserepo/debian/Dockerfile.course-make-install-npm	\
		--build-arg DBW_COURSE_REPO=python						\
		--tag dbwebb/courserepo:python							\
		--tag dbwebb/courserepo:course-python					\
		courserepo/debian
	$(D) build $(options) --file 								\
		courserepo/debian/Dockerfile.course-make-install-npm	\
		--build-arg DBW_COURSE_REPO=oopython					\
		--tag dbwebb/courserepo:oopython						\
		--tag dbwebb/courserepo:course-oopython					\
		courserepo/debian



# target: build-target           - Build specific target=course.
.PHONY: build-target
build-target: update
	@$(call HELPTEXT,$@)
	# target=course
	$(D) build --no-cache $(options) --file 					\
		courserepo/debian/Dockerfile.course-make-install-npm	\
		--build-arg DBW_COURSE_REPO=$(target)					\
		--tag dbwebb/courserepo:$(target)						\
		--tag dbwebb/courserepo:course-$(target)				\
		courserepo/debian



# target: build-website           - Build specific images.
.PHONY: build-website
build-website: update
	@$(call HELPTEXT,$@)
	# website
	$(D) build $(options) --file 								\
		website/Dockerfile.website								\
		--tag dbwebb/website:latest								\
		--tag dbwebb/website:all								\
		website



# target: build-ctf               - Build specific images.
.PHONY: build-ctf
build-ctf: update
	@$(call HELPTEXT,$@)
	# Course repo with ctf utilities.
	$(D) build $(options) --file 							\
		courserepo/debian/Dockerfile.course-ctf-cli			\
		--tag dbwebb/courserepo:ctf							\
		--tag dbwebb/courserepo:ctf-cli						\
		courserepo/debian
	$(D) build $(options) --file 							\
		courserepo/debian/Dockerfile.course-ctf-apache		\
		--tag dbwebb/courserepo:ctf-apache					\
		courserepo/debian



# target: push                    - Push the docker images to Docker cloud.
.PHONY: push
push: push-ctf push-website
	@$(call HELPTEXT,$@)
	# Debian installations
	$(D) push dbwebb/courserepo:debian
	#$(D) push dbwebb/courserepo:jessie
	#$(D) push dbwebb/courserepo:debian-jessie
	$(D) push dbwebb/courserepo:stretch
	$(D) push dbwebb/courserepo:debian-stretch
	$(D) push dbwebb/courserepo:buster
	$(D) push dbwebb/courserepo:debian-buster

	# Base images
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

	# Base images, all included
	$(D) push dbwebb/courserepo:cli
	$(D) push dbwebb/courserepo:all-cli
	$(D) push dbwebb/courserepo:base-all-cli
	$(D) push dbwebb/courserepo:base-debian-all-cli
	$(D) push dbwebb/courserepo:all
	$(D) push dbwebb/courserepo:base-all
	$(D) push dbwebb/courserepo:base-debian-all

	# Course repo
	$(D) push dbwebb/courserepo:cli
	$(D) push dbwebb/courserepo:course-cli
	$(D) push dbwebb/courserepo:course-debian-cli
	$(D) push dbwebb/courserepo:latest
	$(D) push dbwebb/courserepo:web
	$(D) push dbwebb/courserepo:apache
	$(D) push dbwebb/courserepo:course
	$(D) push dbwebb/courserepo:course-debian

	# Course repo with cloned course
	$(D) push dbwebb/courserepo:htmlphp
	$(D) push dbwebb/courserepo:course-htmlphp
	$(D) push dbwebb/courserepo:design
	$(D) push dbwebb/courserepo:course-design
	$(D) push dbwebb/courserepo:databas
	$(D) push dbwebb/courserepo:course-databas
	$(D) push dbwebb/courserepo:oophp
	$(D) push dbwebb/courserepo:course-oophp
	$(D) push dbwebb/courserepo:ramverk1
	$(D) push dbwebb/courserepo:course-ramverk1
	$(D) push dbwebb/courserepo:python
	$(D) push dbwebb/courserepo:course-python
	$(D) push dbwebb/courserepo:oopython
	$(D) push dbwebb/courserepo:course-oopython



# target: push-website            - Push specific images.
.PHONY: push-website
push-website:
	@$(call HELPTEXT,$@)
	# website
	$(D) push dbwebb/website:latest
	$(D) push dbwebb/website:all



# target: push-ctf                - Push specific images.
.PHONY: push-ctf
push-ctf:
	@$(call HELPTEXT,$@)
	# Course repo with ctf
	$(D) push dbwebb/courserepo:ctf
	$(D) push dbwebb/courserepo:ctf-cli
	$(D) push dbwebb/courserepo:ctf-apache
