Revision history
====================



v2.2.0 (2025-03-07)
--------------------

* Upgrade to node 22.



v2.1.0 (2023-08-25)
--------------------

* Added cowsay to debian base.



v2.0.0 (2022-09-02)
--------------------

* Upgrade to Node 18.
* Upgrade to PHP 8.1.



v1.15.0 (2022-06-21)
--------------------

* Added bsdmainutilities.



v1.14.0 (2022-02-10)
--------------------

* Upgrade to Node 17.



v1.13.0 (2021-10-27)
--------------------

* Upgrade to Node 16.



v1.12.0 (2021-10-22)
--------------------

* Upgraded to PHP 80.
* Added webtec as repo.
* Added gawk.



v1.11.0 (2021-05-18)
--------------------

* Re-added xdebug.



v1.10.0 (2021-05-10)
--------------------

* Added to include jq.
* Added new certificates for php repository.
* Removed jessy from being built.
* Cleaned up in Makefile how the flow of building was.



v1.9.7 (2021-01-29)
--------------------

* Added so that .requirements.txt is installed in python and oopython.
* Changed so pylint is to be installed through requirements.txt in each repo.



v1.9.6 (2021-01-14)
--------------------

* Add oopython as a repo.



v1.9.5 (2020-12-09)
--------------------

* Update how website is built.



v1.9.4 (2020-10-16)
--------------------

* Install pylint.
* Fix python UTF-8.
* Upgrade to debian buster.



v1.9.3 (2020-10-16)
--------------------

* Add custom build for python-repo.
* Upgrade to PHP 7.4.



v1.9.2 (2020-09-25)
--------------------

* Add a default apache config to the website image.



v1.9.1 (2020-09-25)
--------------------

* Add latest tag to website image.
* Enable to build and push only website image.



v1.9.0 (2020-09-25)
--------------------

* Add new repo for website with all included.



v1.8.0 (2020-04-23)
--------------------

* Add pre built courserepo for ramverk1.



v1.7.0 (2020-04-22)
--------------------

* Add pre built courserepo for design.



v1.6.0 (2020-04-20)
--------------------

* Add pre built courserepo for htmlphp.



v1.5.0 (2020-04-03)
--------------------

* Add anax-cli.



v1.4.0 (2020-02-20)
--------------------

* Add C#.NET and ASP.NET through dotnet SDK.



v1.3.0 (2020-01-28)
--------------------

* Update to Node v12.
* Update how course specific databas, oophp are built.



v1.2.0 (2019-04-01)
--------------------

* Moved to PHP 7.3 RC4.



v1.1.1 (2019-02-19)
--------------------

* Adding lsof to find processes occuping a port.



v1.1.0 (2019-01-29)
--------------------

* Upgrade node to version 10.
* Add mysql-client to base-all-cli and base-all.



v1.0.2 (2018-12-18)
--------------------

* Add PATH /usr/games to ctf-images.



v1.0.1 (2018-12-17)
--------------------

* Adding ctf utilities bsdgames with caesar and tesseract-ocr for ocr reading.



v1.0.0 (2018-12-17)
--------------------

* Adding tags for dbwebb ctf (ctf) related containers, ctf, ctf-cli and ctf-apache.



v0.9.7 (2018-08-16)
--------------------

* Update so that tags are actually pushed.



v0.9.6 (2018-08-16)
--------------------

* Update tags with cli, web and apache.



v0.9.5 (2018-08-16)
--------------------

* Add PHP extension mbstring, required by phpunit/phpunit.
* Show startup errors in PHP through PHP ini setting.
* Add default config to git.



v0.9.4 (2018-03-05)
--------------------

* Install node through curl needs ca-certificates.
* Add image for course database with tools and utilities installed.



v0.9.3 (2018-03-05)
--------------------

* Restructure how Dockerfiles are built, using modules fom src/.
* Added images for different debian releases.
* Added base-images for node, python, php and apache.
* Added base image with all tools installed.
* Updated course image, to rely on base-all image.



v0.9.2 (2018-02-18)
--------------------

* Adding some Python and some PHP and missing Node tools.



v0.9.1 (2018-02-17)
--------------------

* General docker image for course repos, first try.



v0.9.0 (2018-02-05)
--------------------

* First try.
