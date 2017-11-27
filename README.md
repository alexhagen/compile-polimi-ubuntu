# compile-polimi-ubuntu

> This repository is to be used to compile and install MCNPX-PoLiMi on a
> Ubuntu machine.  While this repository does not provide any source code or
> binaries from MCNP and so can legally be downloaded or cloned by anyone, it is
> only to be used by authorized users of MCNPX-PoLiMi. If you're unaware of what
> that entails, or need MCNP, see [rsicc.ornl.gov](https://rsicc.ornl.gov/).

This repository and the following instructions will help users compile
MCNPX-PoLiMI from source on a Ubuntu machine (tested on 16.04 desktop and
server).  This is to solve an issue that occurs and is not very well supported
by RSICC or the MCNPX-PoLiMi team.  I believe they compile their code on CentOS.
Luckily, I was able to find [this fix from another contributor, although written
in German](https://plus.google.com/108947852622712396341/posts/EPhf2zMvXvP).
I've translated the German and turned this into a somewhat smart script.  Send
me an issue or feature request if you need.

## Installation of MCNPX-PoLiMi on Ubuntu

First, we'll need the MCNP and MCNPX and Polimi files somewhere.  I like to
put all these files in a directory in my home - ``~/mcnp/``.  You'll need the
cds for MCNP(6) and MCNPX-PoLiMi.  When you put in one of these cds, you can
mount it to the directory ``/media/cdrom`` with

```bash
$ sudo mount /dev/cdrom /media/cdrom
```

If you're on a desktop environment, this will happen automatically.  You can
then copy all those files to the proper directory with

```bash
$ mkdir ~/mcnp/
$ sudo mount /dev/cdrom /media/cdrom
$ sudo rsync -r --info=progress2 /media/cdrom/* ~/mcnp/
$ sudo umount /dev/cdrom
```

You can run these last three commands for each CD (there are three).  Make sure
you're not starting them from inside the directory ``/media/cdrom`` or the
``umount`` won't work.

Then, once we have all the files, we have to go into ``~/mcnp/`` and start the
installation

```bash
$ cd ~/mcnp/
$ sudo ./INSTALL_linux-mac-cygwin.sh
```
