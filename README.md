# Bodyweight-Routine

Webserver, web interface, and tools for managing/tracking your body weight routine.

Inspired by https://github.com/mazurio/bodyweight-fitness-ios, which makes it easy to learn the [Reddit Recommended Routine](https://www.reddit.com/r/bodyweightfitness/wiki/kb/recommended_routine), and to keep track of your progressions/reps/times quickly and easily.

Eventually I'm going to need more complex routines, and after searching around for alternatives (the above one has ceased development) and not finding anything I like, I decided to create a new one.

[Changelog](CHANGELOG.md)

## Usage

Go [here](https://fit.brandonokert.com) and play around with the alpha.

## Planned Features

* [ ] Usable on Desktop, IOS, Android, and just about any web browser
* [ ] Built in routines for [Reddits recommended routine](https://www.reddit.com/r/bodyweightfitness/wiki/kb/recommended_routine)
* [ ] Built in routines for [the most common Reddit bwf routines](https://www.reddit.com/r/bodyweightfitness/wiki/index)
* [ ] Tools to quickly build your own routines
* [ ] Rep, Volume, Time, and Progression controls that are easy to adjust mid-workout
* [ ] Tracking for workouts and all the above data
* [ ] Videos for each progression
* [ ] Built in customizable timers for rests, static holds, etc.
* [ ] Save/Export your data

## Maybe Features

* [ ] Support for progressions and concepts in [Overcoming Gravity](http://stevenlow.org/overcoming-gravity/)
* [ ] Getting started guides
* [ ] Integration with [Reddits Bodyweight Fitness community and tools](https://www.reddit.com/r/bodyweightfitness/wiki/index)

## Development

### Setup

Install [yarn](https://yarnpkg.com/en/)
```bash
$ yarn --version
1.6.0
```

Install [nvm](https://github.com/creationix/nvm#install-script) or manually install Node 10
```bash
$ nvm --version
0.33.4
$ node --version
v10.0.0
```

Install [go](https://golang.org/doc/install)
```bash
$ go version
go version go1.10.1 darwin/amd64
```

Install [terraform](https://www.terraform.io/)
```bash
$ terraform --version
Terraform v0.11.8
```

Install [ansible vault](https://docs.ansible.com/ansible/2.6/installation_guide/intro_installation.html#installing-the-control-machine)
I just used brew to install the latest version of ansible, which comes with ansible-vault.
```bash
$ ansible-vault --version
ansible-vault 2.5.0
```

### Building

```bash
# After Pulling:
nvm use
make deps

# Build webserver only:
make build-webserver-dev

# Build frontend only:
make build-frontend-dev

# Build everything from scratch:
make build-dev

# Watch frontend:
make watch-frontend-dev

# Run in dev once built. Can run in parallel with make watch-frontend-dev
make run-dev
```

## Deployment

### Setup infra first time

`make init-infra`

### Apply infrastructure changes

```bash
$ make decrypt-secrets
$ make plan-infra-prod
$ make apply-infra-prod
```

### Deploy to Production

```bash
$ make build-production
$ make decrypt-secrets
$ make deploy-prod
```
