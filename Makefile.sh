#!/bin/bash
cp -r ~/Desktop/mcnp_files/MCNP_CODE/MCNPX/Source/v270/ ./
cp -r ~/cry/cry_v1.7/mcnpx/ ./cry_mcnpx/
cp *.txt v270/src/mcnpx/mcnpf/
cp *.f v270/src/mcnpx/mcnpf/
cp patch_polimi.sh v270/src/mcnpx/mcnpf/
cd v270/src/mcnpx/mcnpf/
sed -i 's/ifort/gfortran/g' patch_polimi.sh
./patch_polimi.sh
cd ~/mcnpx_polimi_cry/
sed -i 's/integer(ki4), external :: iargc/integer(ki4) :: iargc/g' v270/src/bertin/getexm.F
sed -i 's/integer(ki4), external :: iargc/integer(ki4) :: iargc/g' v270/src/htape3x/getexm.F
sed -i 's/integer(ki4), external :: iargc/integer(ki4) :: iargc/g' v270/src/mcnpx/mcnpf/getexm.F
sed -i 's/integer(ki4), external :: iargc/integer(ki4) :: iargc/g' v270/src/phtlib/getexm.F
sed -i 's/integer(ki4), external :: iargc/integer(ki4) :: iargc/g' v270/src/xsex3/getexm.F
mkdir v270_build/
cd v270_build/
chmod -R 0777 ../v270/*
sed -i 's/-lt 76/-lt 0/g' ../v270/configure
cp ../cry_mcnpx/source.F ../v270/src/mcnpx/mcnpf/
../v270/configure --with-FC=f90 --with-CC=gcc-4.4 --host=i686-pc-linux --with-FFLAGS="-DUNIX=1 -DLINUX=1 -DG95=1" --with-CFLAGS="-DUNIX=1 -DLINUX=1" --with-LDFLAGS="-W1 -lstdc++" --x-libraries="/usr/lib -L/usr/lib/libCRY.a -lCRY -lstdc++" --x-include=/usr/include;
make
