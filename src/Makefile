# NOTES:
#
#   - For 'make nomex', define variables MEX_SUFFIX and MATLAB_LIB.
#   - For 'make mex', define variable MEX, and setup mex.
#   - For 'make oct', define variables OCT and OCTAVE_INCLUDE.
#

# CHOOSE MATLAB CONFIGURATION
# This should be the path to your Matlab installation
# you can find it by the commands 'locate matlab' or 'find / -name "matlab"'
MATLAB_HOME = /usr/local/share/matlabR2008b

# For 32-bit Linux, uncomment these 3 lines.
# MEX        = $(MATLAB_HOME)/bin/mex
# MEX_SUFFIX = mexglx
# MATLAB_LIB = -L$(MATLAB_HOME)/bin/glnx86 -lmex

# For 64-bit Linux, uncomment these 3 lines.
MEX        = $(MATLAB_HOME)/bin/mex
MEX_SUFFIX = mexa64
MATLAB_LIB = -L$(MATLAB_HOME)/bin/glnxa64 -lmex

# For Mac OS X, uncomment these 3 lines.
# MEX        = /Applications/MATLAB7/bin/mex
# MEX_SUFFIX = mexmac
# MATLAB_LIB = -L$(MATLAB_HOME)/bin/maci -lmex

# CHOOSE OCTAVE CONFIGURATION
OCTAVE_INCLUDE = /usr/local/include/octave-3.2.4/octave
OCT = mkoctfile

# CHOOSE L-BFGS-B CONFIGURATION
# Uncomment these 2 lines for LBFGSB 2.4.
# LBFGSB_OBJS = solver24.o
# LIBS =

# Uncomment these 2 lines for LFBGSB 3.0 with the BLAS code included along
# with the rest of the code in this repository.
LBFGSB_OBJS = solver30.o linpack.o timer.o blas.o
LIBS =

# Uncomment the following 2 lines for LFBGSB 3.0 with your locally 
# installed BLAS library.
# LBFGSB_OBJS = solver30.o linpack.o timer.o
# LIBS = -lblas

# CHOOSE FORTRAN COMPILER
FFLAGS = -O3 -fPIC -fexceptions -Wall -g -Wno-uninitialized

# If f77 is your Fortran compiler, uncomment these 2 lines.
# F77         = f77
# FORTRAN_LIB = g2c

# If gfortran is your Fortran compiler, uncomment the following two lines.
F77         = gfortran
FORTRAN_LIB = gfortran

# CONFIGURE C++ COMPILER.
CXX    = g++
CFLAGS = -O3 -fPIC -pthread -Wall -Werror -ansi -ffast-math \
         -fomit-frame-pointer

# If you need to specify extra directories where to look for libraries, 
# write the paths of the directories, separated by a white space.
#LIBDIRS = /usr/lib/gcc/x86_64-linux-gnu/4.8/
LIBDIRS = 

# Choose your installation directory relative to the src directory.
INSTALLDIR = ../lib

######################################################################
### Do not edit below ################################################
######################################################################

TARGET  = lbfgsb
OBJS    = $(LBFGSB_OBJS) matlabexception.o matlabscalar.o matlabstring.o \
	matlabmatrix.o arrayofmatrices.o program.o matlabprogram.o \
	lbfgsb.o

%.o: %.cpp
	$(CXX) $(CFLAGS) -I$(OCTAVE_INCLUDE) \
	-I$(MATLAB_HOME)/extern/include -o $@ -c $^

%.o: %.f
	$(F77) $(FFLAGS) -o $@ -c $^

all: nomex


mex:   $(TARGET)_mex     tidy

nomex: $(TARGET)_nomex   tidy

octave: $(TARGET)_octave tidy

oct: octave

$(TARGET)_mex: $(OBJS)
	$(MEX) -cxx CXX=$(CXX) CC=$(CXX) FC=$(FCC) LD=$(CXX) \
	-l$(FORTRAN_LIB) -lm -O -output $@ $^

$(TARGET)_nomex: $(OBJS)
	$(CXX) $^ -shared -o $(TARGET).$(MEX_SUFFIX) $(MATLAB_LIB) \
	$(addprefix -L,$(LIBDIRS)) -l$(FORTRAN_LIB) -lm

$(TARGET)_octave: $(OBJS)
	$(OCT) --mex -o $(TARGET).mex $^ $(LIBS)$

create-install-dir:
	@if [ ! -e $(INSTALLDIR) ]; then \
	mkdir $(INSTALLDIR); \
	fi
	cp *.m $(INSTALLDIR)

install: create-install-dir
	mv $(TARGET).mex* $(INSTALLDIR)

tidy:
	rm -f *.o

clean: tidy
	rm -f $(INSTALLDIR)/$(TARGET).mex*

deep-clean:
	rm -f $(INSTALLDIR) -R
