# Emacs Version Manager

## Why EVM?

* Did you ever wonder how to install Emacs? Homebrew, apt-get, Emacs
  for OSX, Compile from scratch, etc...

* Are you currently maintaining an Emacs package? How do you know it
  works? Because you have tests of course. Ok, so you know it works on
  your platform and with your Emacs version. But what about all other
  versions that people are using? Does your package work for them?

* EVM provides pre compiled binaries to allow for quick installation
  on CI systems.

## Platform Support

### OSX

Supported!

### GNU/Linux

Supported!

### Windows

Not supported. Need help from someone running Windows.

## Installation

EVM installs all Emacs versions under `/usr/local/evm`. This is not
configurable and that is because EVM provides pre compiled binaries,
which unfortunately must run in the directory it was compiled for.

No matter what installation approach you choose, create
`/usr/local/evm` and give your user access rights:

```sh
$ sudo mkdir /usr/local/evm
$ sudo chown $USER: /usr/local/evm
```

### Automatic

```sh
$ curl -fsSkL https://raw.github.com/rejeep/evm/master/go | bash
```

Add EVM's `bin` directory to your `PATH`.

```sh
$ export PATH="$HOME/.evm/bin:$PATH"
```

### Homebrew

_NOT ADDED YET_

```sh
$ brew install evm
```

### Ruby gem

```sh
$ gem install evm
```

### Manual

```sh
$ git clone https://github.com/rejeep/evm.git ~/.evm
```

Add EVM's `bin` directory to your `PATH`.

```sh
$ export PATH="$HOME/.evm/bin:$PATH"
```

## Usage

In the Evm `bin` directory, there are two commands:

* `evm` - Manage Emacs packages
* `emacs` - Emacs binary for currently selected Emacs package

### list

To list all available Emacs versions you can install, run:

```sh
$ evm list
```

The output will look something like this:

```
emacs-23.4
emacs-24.1 [I]
emacs-24.2
* emacs-24.3 [I]
emacs-24.3-bin [I]
...
```

The `[I]` shows what versions are currently installed and the `*`
shows what version is currently selected.

_NOTE: The versions with the `-bin` suffix should only to be used for testing._

### install <name>

To install a version, run:

```sh
$ evm install version
```

Example:

```sh
$ evm install emacs-24.3
```

### use <name>

To start using a specific package, run:

```sh
$ evm use name
```

Example:

```sh
$ evm use emacs-24.2
```

The Evm `emacs` binary will update and use that Emacs package.

### uninstall <name>

To uninstall a version, run:

```sh
$ evm uninstall emacs-24.2
```

### bin [name]

Prints the full path to `name`'s Emacs executable. If no name is
specified, use currently selected.

```sh
$ evm bin
$ evm bin emacs-24.2
```

### help

For more information, run:

```sh
$ evm --help
```

## Contribution

Be sure to!

Implement the features and don't forget to test it. Run the tests
with:

```sh
$ rspec spec
```

If all passes, send us a
[pull request](https://github.com/rejeep/evm/pulls) with the changes.

### Adding a new Emacs version

Copy an existing recipe in the [recipes](/recipes) directory and make
modifications for the new version.  Also add the new version to the
[Travis configuration](/.travis.yml).

### Adding precompiled binary

If you want to contribute a precompiled binary, these instructions will help.

#### Linux

* Install [Vagrant](https://www.vagrantup.com/)

* Install Vagrant SCP (https://github.com/invernizzi/vagrant-scp)

* Clone https://github.com/travis-ci/travis-cookbooks

* Enter `travis-cookbooks` and run `vagrant up`

* SSH into the VM: `$ vagrant ssh ID`

* Install necessary tools

```bash
$ sudo apt-get install libncurses-dev
$ sudo apt-get install autoconf
$ sudo apt-get install automake
$ sudo apt-get install git
```

* Download Emacs source

```bash
$ wget http://ftpmirror.gnu.org/emacs/emacs-MAJOR.MINOR.tar.gz
```

* Unzip it

```bash
$ tar -xvzf emacs-MAJOR-MINOR.tar.gz
```

* Compile and Install Emacs

```bash
$ ./configure --without-all --prefix=/usr/local/evm/emacs-MAJOR.MINOR-bin
$ make bootstrap
$ make install
```

* Tar it

```bash
$ tar -cvzf emacs-MAJOR-MINOR-linux.tar.gz /usr/local/evm/emacs-MAJOR.MINOR-bin
```

* Copy from VM

```bash
$ vagrant scp ID:/usr/local/evm/emacs-MAJOR.MINOR-linux.tar.gz .
```

* Add zip file to [evm-bin](https://github.com/rejeep/evm-bin) and send a pull request
