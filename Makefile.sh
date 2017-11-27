#!/bin/bash
echo 'Installing requirements'
add-apt-repository "deb http://archive.ubuntu.com/ubuntu trusty main universe"
add-apt-repository "deb http://archive.ubuntu.com/ubuntu trusty-updates main universe"
apt update
apt install unzip gcc-4.4 g++-4.4 gfortran-4.4 build-essential libx11-dev
ln -s /usr/bin/gfortran-4.4 /usr/bin/f90
cp ~/mcnpxcd/v2.0.0_-_Release.zip ./
unzip v2.0.0_-_Release.zip
cp -r v2.0.0\ -\ Release/Patch/*.txt ./
cp -r v2.0.0\ -\ Release/Patch/*.f ./
cp -r v2.0.0\ -\ Release/Patch/patch_polimi.sh ./
chmod 0777 patch_polimi.sh
cp -r ~/mcnp/MCNP_CODE/MCNPX/Source/v270/ ./
cp *.txt v270/src/mcnpx/mcnpf/
cp *.f v270/src/mcnpx/mcnpf/
cp patch_polimi.sh v270/src/mcnpx/mcnpf/
cd v270/src/mcnpx/mcnpf/
sed -i 's/ifort/gfortran/g' patch_polimi.sh
./patch_polimi.sh
cd ~/mcnp/polimi_compiled/
sed -i 's/integer(ki4), external :: iargc/integer(ki4) :: iargc/g' v270/src/bertin/getexm.F
sed -i 's/integer(ki4), external :: iargc/integer(ki4) :: iargc/g' v270/src/htape3x/getexm.F
sed -i 's/integer(ki4), external :: iargc/integer(ki4) :: iargc/g' v270/src/mcnpx/mcnpf/getexm.F
sed -i 's/integer(ki4), external :: iargc/integer(ki4) :: iargc/g' v270/src/phtlib/getexm.F
sed -i 's/integer(ki4), external :: iargc/integer(ki4) :: iargc/g' v270/src/xsex3/getexm.F
mkdir v270_build/
cd v270_build/
chmod -R 0777 ../v270/*
sed -i 's/-lt 76/-lt 0/g' ../v270/configure
../v270/configure --with-FC=f90 --with-CC=gcc-4.4 --host=i686-pc-linux --with-FFLAGS="-DUNIX=1 -DLINUX=1 -DG95=1" --with-CFLAGS="-DUNIX=1 -DLINUX=1" --with-LDFLAGS="-W1 -lstdc++" --x-libraries="/usr/lib -lstdc++" --x-include=/usr/include;
make
