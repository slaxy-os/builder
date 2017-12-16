# Slaxy Live Linux Operating System Builder

This is a collection of scripts to create a customized slaxy linux live operating system with the help
of [Docker](http://docker.com/).

## What is Slaxy

Slaxy is a modification helper for custom builds of the [Slax live distribution](http://slax.org).

## How to use

Modules must have the following folder structure:

* `bootlogo.png`
* `modules/`
* `modules/{ module-name }/`
* `modules/{ module-name }/init.d/`
* `modules/{ module-name }/init.d/{ script-name }.sh`

You have to create scripts for provisioning in the modules `init.d` folder as shell-scripts with an `.sh` file ending.

Within the docker container the `modules/{ module-name }/` folder is reachable with the help of the environment variable
`$EXCHANGE_PATH`.

### How to build a complete live image

Run the build-script of this repository:

```bash
/path/to/this/repo/build.sh /path/to/your/distro
# OR
/path/to/this/repo/build.sh # It will use the current directory as module path
```

After that you will find your distro in the `dist` folder in your current working directory.

### How to build a single sb module

Just run `create-sb.sh` in your module directory, or give the path to the module as first argument

```bash
/path/to/this/repo/create-sb.sh /path/to/module
# OR
/path/to/this/repo/create-sb.sh # It will use the current directory as module path
```

After that you will find your created module in `/path/to/module/dist`.
