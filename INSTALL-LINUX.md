# Linux Installation Instructions

This file gives you instructions about how to compile and install lbfgsb-matlab under Ubuntu Linux for Matlab and Octave. For other Octave installations, this can still be used as a guide-line. For general information, license and usage instructions, read the README.md

**Versions used in this manual:**
lbfgsb-matlab has been compiled with gcc versions 4.6.3 and 4.6.4, under Ubuntu 12.10 and 13.10, and tested with Octave 3.6.2, 3.6.4, 3.8.0 and 3.8.1.

###Install the required tools
You will need a C++ and Fortran compiler. We will use gcc and gfortran

    sudo apt-get install build-essential gfortran

You will of course need a working installation of Matlab or Octave. In the case of Octave, if you don't have it the easiest way to install it is from the repositories

    sudo apt-get install octave

If you want to use more recent versions of Octave, you will have to [install it from the sources](http://www.gnu.org/software/octave/doc/interpreter/Installation.html).
After that, find the path to the mkoctfile compiler (in the bin directory) and the include directory. You will need those later.

Additionally you will need all the necessary tools, libs and header files to compile MEX
files.

    sudo apt-get install liboctave-dev


###Download lbfgsb-matlab source code
Clone or fork this repository, or download this repository as a
[ZIP file](https://github.com/josombio/lbfgsb-matlab/archive/master.zip)
and unpack the ZIP file to a folder of your choice. In the following we will refere to this directory as LBFGSB_HOME. 
Wherever you find LBFGSB_HOME, you should substitute it with your own directory.

###Modify the Makefile
Open and fine-tune the self-explanatory Makefile located inside the LBFGSB_HOME/src directory according to your needs. With this Makefile you can create
- a mex file for Mtlab using the mex compiler (mex taget)
- a mex file for Matlab using your C compiler (nomex target)
- a mex file for Octave using mkoctfile (oct target)

Regarding the compilation for Octave, the variable **OCTAVE_INCLUDE** is the directory where the Octave header files required for development are installed. Make sure that it points to the right directory corresponding to the Octave version that you have installed. In this case it points to the version that we installed using apt-get. **OCT** is the command to call the mkoctfile compiler. If mkoctfile is in the path, simply leave it as it is. If not, include in the variable the full path to it. If you have several versions of Octave installed, make sure that MEX points to the mkoctfile of the installation that you will compile and use lbfgsb-matlab with.
    
**INSTALLDIR** is the installation directory relative to the LBFGSB_HOME/src directory. After the compilation, the mex file and all the m files (containing the documentation and the examples) will be placed in this directory. If this directory does not exist, it will be automatically created.

###Build the MEX file
Call make from the LBFGSB_HOME/src directory using the appropriate target. Either

    make oct
    make nomex 
    make mex

###Installation
Installing the mex file is as simple as placing it wherever Octave/Matlab can find it, that is, in its path. That is all. There are many ways to do this. Whatever is your way, note that the mex file does not contain the usage documentation, which is written in lbfgsb.m. So wherever you place lbfgsb.mex, make sure that you place lbfgsb.m in the same directory.

My choice of installation is to copy lbfgsb.mex and lbfgsb.m to a specific folder and then add it to Octave's path, so that lbfgsb can be called independently of the Octave's working directory that I am using. The command

    make install

will create the .mex and .m files to the INSTALLDIR directory, which will be automatically created if it does not exist. Adding the installation directory to Octave's path can be done using the command addpath from within Octave

    addpath('LBFGSB_HOME/lib');

However, once you exit Octave the updated path is not preserved, and you would need to use addpath in every new Octave session in which you need lbfgsb. Alternatively, you can add the previous addpath command to ~/.octaverc. This way it will be automatically executed every time you start Octave. To do so, you can simply execute

    savepath

or edit manually your  ~/.octaverc. That is all. You can now run the examplehs038 to test your lbfgsb installation.

###Cleaning
Calling

    make clean

will delete the mex files from the installation directory, and 

    make deep-clean

will delete the whole installation directory. The intermediate binaries created during compilation are automatically deleted after compilation.
