# Octave Installation Instructions

This file gives you instructions about how to compile and install lbfgsb-matlab in octave under Ubuntu Linux. For other octave installations, this can still be used as a guide-line. For general information, license and usage instructions, read the README.md

Versions used in this manual:
lbfgsb-for-matlab has been compiled with gcc version 4.6.3 under Ubuntu 12.10, and tested with versions 3.6.2 and 3.6.4 of octave.

**Install octave and required tools**
You will need a C++ and Fortran compiler. We will use gcc and gfortran

    sudo apt-get install build-essential gfortran
    
You will of course need a working installation of OCTAVE. If you don't have it, the easiest way to install it is from the repositories

    sudo apt-get install octave

If you want to use more recent versions of octave, you will have to [install octave from the sources](http://www.gnu.org/software/octave/doc/interpreter/Installation.html).
After that, find the path to the mkoctfile compiler (in the bin directory) and the include directory. You will need those later.

Additionally you will need all the necessary tools, libs and header files to compile MEX
files.

    sudo apt-get install liboctave-dev


**Download the source code.**
Clone or fork this repository, or download this repository as a
[ZIP file](http://github.com/pcarbo/lbfgsb-matlab/archive/master.zip)
and unpack the ZIP file to a folder of your choice. I use ~/octave/lbfgsb-for-matlab/. Recall that ~/octave is the directory where OCTAVE puts user installed forge packages when using the pkg command. I personally use it also to place source from any external projects that I use. But you choose whatever directory you want. In the following we will refere to this directory as LBFGSB_HOME.

**Modify the Makefile.**
Inside LBFGSB_HOME/src you will find two different Makefiles: Makefile and Makefile-oct. The first one handles the complilation specifically for Matlab, and the the second one for Octave. Open Makefile-oct and edit the variables according to your needs.

    OCTAVE_INCLUDE = /usr/include/octave-3.6.2/octave/
    MEX            = mkoctfile
    MEXLIBDIR	    = ../lib
    
    CXX            = g++
    F77            = gfortran
    CFLAGS         = -O3 -fPIC -pthread -Wall -Werror -ansi -ffast-math -fomit-frame-pointer -fPIC
    FFLAGS         = -O3 -fPIC -fexceptions 

The variable **OCTAVE_INCLUDE** is the directory where the octave header files required for development are installed. Make sure that it points to the right directory corresponding to the octave version that you have installed. In this case it points to the version that we installed using apt-get.
**MEX** is the command to call the mkoctfile compiler. If mkoctfile is in the path, simply leave it as it is. If not, include in the variable the full path to it. If you have several versions of octave installed, make sure that MEX points to the mkoctfile of the installation that you will compile and use lbfgsb-matlab with.
**CXX** is the C++ compiler. In our case it is g++, which is in our your path.
**F77** is the fortran compiler. We chose and installed gfortran, which is in our path.
**CFLAGS** and **FFLAGS** are the flags passed to g++ and gfortran respectively when compiling the sources. Check the gcc and gfortran documentation to understand (and perhaps change) the flags.

**Build the MEX file.**
Call make from the LBFGSB_HOME/src directory making sure that you use the specific Makefile for OCTAVE. To do so use the -f option of make followed by the octave compilation specific makefile

    make -f Makefile-oct

You should see how g++ and gfortran do their job and how mkoctfile links all the object files producing lbfgsb.mex.

**Installation**
Installing the mex file is as simple as placing it wherever OCTAVE can find it, that is, in its path. That is all. There are many ways to do this. Whatever is your way, note that the mex file does not contain the usage documentation, which is written in lbfgsb.m. So wherever you place lbfgsb.mex, make sure that you place lbfgsb.m in the same directory.

My choice of installation is to copy lbfgsb.mex and lbfgsb.m to LBFGSB_HOME/lib (which should be created first) and then add LBFGSB_HOME/lib to octave's path, so that lbfgsb can called independently of the octave's working directory that I am using. In order to create the lib directory and copy the .mex and .m files to it, you can do

    make -f Makefile-oct install

Adding the lib directory to octave's path can be done using the command addpath from within octave

    addpath('LBFGSB_HOME/lib');
    
However, once you exit octave the updated path is not preserved, and you would need to use addpath in every new octave session in which you need lbfgsb. Alternatively, you can add the previous addpath command to ~/.octaverc. This way it will be automatically executed every time you start octave. To do so, you can simply execute

    savepath

or edit manually your  ~/.octaverc. That is all. You can now run the examplehs038 to test





