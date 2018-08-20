# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.0.2] - 2018-08-19

* Created initial production infra terraform (network + security groups + single webserver)
* Ran terraform to create production environment, and got it working over the web (including dns)
* Can now access alpha site at fit.brandonokert.com
* Created local deploy scripts and tasks, both for artifact and for server files
* Created basic systemd service to keep service process up and maintainable
* Created encrypted secrets and decryption mechanism
* Added simple production configuration mechanism for web server (--production flag)

### Notes

* Does not include any sort of structured provisioning (eg installs), just basic files

## [0.0.1] - 2018-08-19

### Added

* Created initial webserver that serves static files, handles 404s, serves an index, and has basic status endpoints
* Created initial frontend that generates its own html file with hash that can be served by the webserver
* Setup Makefile
* Setup project settings
* Created dev environment for watching and building (doesn't include tests yet)
* Created production artifact tools
* Created initial README

### Notes

* Does not include infrastructure yet
* Does not include deployment yet
* Does not include testing/ci yet
* Does not include linting/precommit hooks yet
