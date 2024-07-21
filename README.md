# env-setup
Documentation and `Makefile` to configure a blank development environment.

# :exclamation: Warning :exclamation:
This repository contains a `Makefile` that is designed to setup a development environment. The `Makefile` executes commands and installs software on your machine. It is generally advised to be aware of the software you are installing before doing so.

# Assumptions
- The development environment was setup on `Ubuntu 24.04 LTS`
- Manually install your IDE, eg: `vscode` 

# Installed Programs
- Linux Base Packages
- Perl
- Git
- Python, Pip
- Golang

# Chicken and the Egg
The makefile exists on github, it has commands to install and configure your development environment, including git. But you can't clone this repo and use it without git on the machine. Just create a makefile locally and copy it's contents to your local file.

# Steps
## 1. Init
This first step runs and update and upgrade on all the existing software packages on your system. It also installs basic packages for developing
```
make init
```

## 2. Git
### Install
Uses `apt` to install git
```
make git install
```

### Configure
Sets up username and email via makefile arguments
```
make git-init user=<your user> email=<your email>
```

## 3. Python
Uses `apt` to install and verify installtion of the latest version of python
```
make python-install
```

## 4. Go
### Get version
Runs a shell command to get the latest version from Go's website
```
make go-latest-version
```

### Install
Use previous command to get version, pass via argument. Download package via instructions on go's website. Update `PATH` in `/etc/environment` to include Go's install path. Note, if this doesn't work, manually update your `~/.profile` file with `PATH="/usr/local/go/bin:$PATH"` (put it at the end)
```
make go-install
```