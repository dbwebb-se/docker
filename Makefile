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
# http://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux/27776822#27776822
ifneq (, $(findstring CYGWIN, $(OS)))
	ECHO = /bin/echo -e
endif

# Colors and helptext
NO_COLOR	= \033[0m
ACTION		= \033[32;01m
OK_COLOR	= \033[32;01m
ERROR_COLOR	= \033[31;01m
WARN_COLOR	= \033[33;01m

# Which makefile am I in?
WHERE-AM-I = $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
THIS_MAKEFILE := $(call WHERE-AM-I)

# Echo some nice helptext based on the target comment
HELPTEXT = $(ECHO) "$(ACTION)--->" `egrep "^\# target: $(1) " $(THIS_MAKEFILE) | sed "s/\# target: $(1)[ ]*-[ ]* / /g"` "$(NO_COLOR)"

# Check version  and path to command and display on one line
CHECK_VERSION = printf "%-15s %-10s %s\n" "`basename $(1)`" "`$(1) --version $(2)`" "`which $(1)`"

# Print out colored action message
ACTION_MESSAGE = $(ECHO) "$(ACTION)---> $(1)$(NO_COLOR)"



# target: help               - Displays help.
.PHONY:  help
help:
	@$(call HELPTEXT,$@)
	@sed '/^$$/Q' $(THIS_MAKEFILE) | tail +3 | sed 's/#\s*//g'
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



# target: build              - Build the docker images.
.PHONY: build
build:
	@$(call HELPTEXT,$@)
	$(D) build --file courserepo/debian/Dockerfile.base		\
		--tag dbwebb/courserepo:base						\
		courserepo/debian
	$(D) build --file courserepo/debian/Dockerfile.course	\
		--tag dbwebb/courserepo:databas						\
		--build-arg COURSEREPO=databas						\
		courserepo/debian
	$(D) build --file courserepo/debian/Dockerfile.course	\
		--tag dbwebb/courserepo:oopython					\
		--build-arg COURSEREPO=oopython						\
		courserepo/debian
	$(D) build --file courserepo/debian/Dockerfile.course	\
		--tag dbwebb/courserepo:linux						\
		--build-arg COURSEREPO=linux						\
		courserepo/debian
 


# target: push               - Push the docker images to Docker cloud.
.PHONY: push
push:
	@$(call HELPTEXT,$@)
	$(D) push dbwebb/courserepo:base
	$(D) push dbwebb/courserepo:databas
	$(D) push dbwebb/courserepo:oopython
	$(D) push dbwebb/courserepo:linux
