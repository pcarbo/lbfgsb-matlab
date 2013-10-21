# Linux settings.
MEX         = mex
MEXSUFFIX   = mexglx
MATLAB_HOME = /cs/local/generic/lib/pkg/matlab-7.3
CXX         = g++-3.4.5
F77         = g77-3.4.5
CFLAGS      = -O3 -fPIC -pthread 
FFLAGS      = -O3 -fPIC -fexceptions 

# Mac OS X settings.
MEX         = mex
MEXSUFFIX   = mexmac
MATLAB_HOME = /Applications/MATLAB72
CXX         = g++
F77         = g77 
CFLAGS      = -O3 -fPIC -fno-common -fexceptions -no-cpp-precomp 
FFLAGS      = -O3 -x f77-cpp-input -fPIC -fno-common 

TARGET = lbfgsb.$(MEXSUFFIX)
OBJS   = solver.o matlabexception.o matlabscalar.o matlabstring.o   \
         matlabmatrix.o arrayofmatrices.o program.o matlabprogram.o \
         lbfgsb.o

CFLAGS += -Wall -ansi -DMATLAB_MEXFILE

all: $(TARGET)

%.o: %.cpp
	$(CXX) $(CFLAGS) -I$(MATLAB_HOME)/extern/include -o $@ -c $^

%.o: %.f
	$(F77) $(FFLAGS) -o $@ -c $^

$(TARGET): $(OBJS)
	$(MEX) -cxx CXX=$(CXX) CC=$(CXX) FC=$(FCC) LD=$(CXX) -lg2c -lm \
        -O -output $@ $^

clean:
	rm -f *.o $(TARGET)

