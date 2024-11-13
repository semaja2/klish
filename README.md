# Klish Project

## About

The klish is a framework for implementing a CISCO-like or Juniper-like
CLI on a UNIX systems.

Current version 3 is not compatible to previous stable 2.2 branch. It's
fully rewritten version. It has another architecture and config file
format.

For previous stable klish version 2 see the "2.2" branch.

The main target for the klish is a Linux platform.


## Build

The version 3 needs libfaux (https://faux.libcode.org) to be built.
klish-3.1.0 based on [faux-2.2.0](https://src.libcode.org/download/faux/faux-2.2.0.tar.xz)


### Building and installing from source
Build instructions based on Debian (bookworm) or Ubuntu 22.04
 1. Install build tools and dependencies (`apt-get -y install build-essential git libtool autoconf libxml2-dev expat pkg-config`)
 2. Download and compile/install faux
 ```
    wget https://src.libcode.org/download/faux/faux-2.2.0.tar.xz
    tar xf faux-2.2.0.tar.xz
    cd faux-2.2.0
    ./configure --prefix=/usr
    make
    make install
 ```
 3. Clone source (`git clone https://src.libcode.org/pkun/klish.git`)
 4. Change into cloned source directory (`cd klish`)
 5. Create configure script (`./autogen.sh`)
 6. Configure make (`./configure.sh`)
 7. Build (`make`)
 8. Install (`make install`)
 9. Copy example configurations
    ```
        mkdir /etc/klish
        copy klish.conf /etc/klish/klish.conf
        copy klishd.conf /etc/klish/klishd.conf
        copy examples/simple/example.xml /etc/klish/example.xml
    ```
10. Start klishd with verbose and foreground to check for errors (`klishd -d -v`)


### Building deb file

amd64 deb file can be created with below after installing dependencies and building with `make deb` command

### Building Docker image

Dockerfile has been provided to enable quick building of docker image containing functional klish

`docker build . -t klish3 && docker run -it klish3`

## Resources

Homepage : http://klish.libcode.org

Docs : https://src.libcode.org/pkun/klish/src/master/docs/klish3.ru.md (in Russian)

Repository : https://src.libcode.org/pkun/klish

Mailing list : http://groups.google.com/group/klish

Dev mailing list : http://groups.google.com/group/klish-dev

Download : https://src.libcode.org/download/klish/

Latest release : https://src.libcode.org/download/klish/klish-3.1.0.tar.xz

Author : Serj Kalichev `pkun(_at_)libcode.org`
