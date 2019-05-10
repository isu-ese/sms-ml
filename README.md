# Machine Learning Enhanced Systematic Mapping Studies

## Dependencies

This project has several dependencies. Here are instructions to install each one:

### Pandoc and extensions

Pandoc can be installed using the default package installer on many linux systems. On ubuntu,
this project uses features that the default version does not have. To install the newest version on ubuntu,
follow these steps.

#### Install the Haskall Platform

    sudo apt-get install haskell-platform

#### Update Cabal

    cabal install cabal-install

#### Set bash to use updated cabal by default

    echo "alias cabal='~/.cabal/bin/cabal'" >> .bashrc
    source .bashrc

#### Configure location of installed binaries and set path

    sed -e '/-- symlink-bindir/c symlink-bindir = ~/.cabal/bin' ~/.cabal/config > ~/.cabal/config
    echo "export PATH="$PATH:~/.cabal/bin" >> .bashrc
    source .bashrc

#### Install pandoc and extensions

    cabal new-install pandoc pandoc-crossref pandoc-citeproc

### Markdown Pre Processor

The markdown pre-processor is a python package. To install with pip do:

    sudo pip install MarkdownPP

Make sure to use the sudo command so that the package is available on the path.

### Fonts

This project uses the Futura LT BT font. To install, execute the following command:

    mkdir -p ~/.fonts && curl https://www.cufonfonts.com/download/font/futura-lt-bt > /tmp/futura-lt-bt-fonts.zip && unzip /tmp/futura-lt-bt-fonts.zip -d ~/.fonts

## Building the document

Then execute the following command:

```
$ report/build.sh
```

## Building the presentation

To build the presentation you will need the same dependencies as noted above

You can then build the presentation via the following command:

```
$ presentation/build.sh
```
