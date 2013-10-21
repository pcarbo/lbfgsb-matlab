# A MATLAB interface for L-BFGS-B

###Overview

L-BFGS-B is a collection of Fortran 77 routines for solving
large-scale nonlinear optimization problems with bound constraints on
the variables. One of the key features of the nonlinear solver is that
knowledge of the Hessian is not required; the solver computes search
directions by keeping track of a quadratic model of the objective
function with a limited-memory BFGS (Broyden-Fletcher-Goldfarb-Shanno)
approximation to the Hessian (1). The algorithm was developed by Ciyou
Zhu, Richard Byrd and Jorge Nocedal. For more information, go to the
[original distribution site](http://www.ece.northwestern.edu/~nocedal/lbfgsb.html)
for the L-BFGS-B software package.

I've designed an interface to the L-BFGS-B solver so that it can be
called like any other function in MATLAB (2). See the text below for
more information on installing and calling this function in
MATLAB. Along the way, I've also developed a C++ class that
encapsulates all the "messy" details in executing the L-BFGS-B
code. See below for instructions on how to incorporate this C++ class
info your own code.

I've tested this software in MATLAB on both the Mac OS X and Linux
operating systems (it has also been used successfully on Windows; see
below).

###License

Copyright (c) 2013, Peter Carbonetto

The lbfgsb-matlab project repository is free software: you can
redistribute it and/or modify it under the terms of the
[GNU General Public License](http://www.gnu.org/licenses/gpl.html) as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but
**without any warranty**; without even the implied warranty of
**merchantability** or **fitness for a particular purpose**. See
[LICENSE](LICENSE) for more details.

###Installation

These installation instructions assume you have a UNIX-based operating
system, such as Mac OS X or Linux. (If you have a Windows operating
system, Guillaume Jacquenot has generously provided
[instructions](Compile_LBFGSB_on_Windows.txt) for compiling the
software on Windows with [gnumex](http://gnumex.sourceforge.net) and
Mingw. These instructions also assume you have GNU
[make](http://www.gnu.org/software/make/) installed.

**Download the source.** First, download and unpack the
[tar archive](lbfgsb-for-matlab.tar.gz). **FIX THIS** It contains some
MATLAB files (ending in .m), some C++ source and header files (ending
in .h and .cpp), a single Fortran 77 source file solver.f containing
the L-BFGS-B routines, and a Makefile. I've included a version of the
Fortran routines that is more recent than what is available for
download at the
[distribution site](http://www.ece.northwestern.edu/~nocedal/lbfgsb.html)
at Northwestern University.

What we will do is create a MEX file, which is basically a file that
contains a routine that can be called from MATLAB as if it were a
built-it function. To learn about MEX files, I refer you to
[this document](http://www.mathworks.com/support/tech-notes/1600/1605.html)
on the MathWorks website.

**Install the C++ and Fortran 77 compilers.** In order to build the
MEX file, you will need both a C++ compiler and a Fortran 77
compiler. Unfortunately, you can't just use any compiler. You have to
use the precise one supported by MATLAB. For instance, if you are
running Mac OS X 7.2 on a Linux operating system, you will need to
install [GNU compiler collection](http://www.gnu.org/software/gcc)
(GCC) version 3.4.4. Even if you already have a compiler installed on
Linux, it may be the wrong version, and if you use the wrong version
things could go horribly wrong. It is important that you use the
correct version of the compiler, otherwise you will encounter linking
errors. Refer to
[this document](http://www.mathworks.com/support/tech-notes/1600/1601.html)
to find out which compiler is supported by your version of MATLAB.

**Configure MATLAB.** Next, you need to set up and configure
MATLAB to build MEX Files. This is explained quite nicely in <a
href="http://www.mathworks.com/support/tech-notes/1600/1605.html">this
MathWorks support document</a>.</p>

<p><b>Simple compilation procedure.</b> (Thanks to Stefan Harmeling.) You
  might be able to build and compile the MEX File from source code simply by
  calling MATLAB's mex program with the C++ and Fortran source files as 
  inputs like so:</p>

<p><code><pre>  mex -output lbfgsb *.cpp solver.f</pre></code></p>

<p>If that doesn't work (you get linking errors or it makes MATLAB crash 
  when you try to call it) then you may have to follow the complicated 
  installation instructions below.</p>

<p><b>Modify the Makefile.</b> You are almost ready to build the MEX
file. But before you do so, you need to edit the Makefile to coincide
with your system setup. At the top of the file are several variables
you may need to modify. The variable <code>MEX</code> is the
executable called to build the MEX file. The variables
<code>CXX</code> and <code>F77</code> must be the names of your C++
and Fortran 77 compilers. <code>MEXSUFFIX</code> is the MEX file
extension specific to your platform. (For instance, the extension for
Linux is <code>mexglx</code>.) The variable <code>MATLAB_HOME</code>
must be the base directory of your MATLAB installation. Finally,
<code>CFLAGS</code> and <code>FFLAGS</code> are options passed to the
C++ and Fortran compilers, respectively. Often these flags coincide
with your MEX options file (see <a
href="http://www.mathworks.com/support/tech-notes/1600/1605.html">here</a>
for more information on the options file). But often the settings in
the MEX option file are incorrect, and so the options must be set
manually. MATLAB requires some special compilation flags for various
reasons, one being that it requires position-independent code. These
instructions are vague (I apologize), and this step may require a bit
of trial and error until before you get it right.</p>

<p>On my laptop running Mac OS X 10.3.9 with MATLAB 7.2, my settings
for the Makefile are</p>

<p><code><pre>  MEX         = mex
  MEXSUFFIX   = mexmac
  MATLAB_HOME = /Applications/MATLAB72
  CXX         = g++
  F77         = g77 
  CFLAGS      = -O3 -fPIC -fno-common -fexceptions \
                -no-cpp-precomp 
  FFLAGS      = -O3 -x f77-cpp-input -fPIC -fno-common</pre></code></p>

<p>On my Linux machine, I set the variables in the Makefile like so:</p> 

<p><code><pre>  MEX         = mex
  MEXSUFFIX   = mexglx
  MATLAB_HOME = /cs/local/generic/lib/pkg/matlab-7.2
  CXX         = g++-3.4.5
  F77         = g77-3.4.5
  CFLAGS      = -O3 -fPIC -pthread 
  FFLAGS      = -O3 -fPIC -fexceptions</pre></code></p>

<p>It may be helpful to look at the GCC documentation in order to
understand what these various compiler flags mean.</p>

<p><b>Build the MEX file.</b> If you are in the directory containing all 
the source files, typing 
<code>make</code> in the command prompt will first compile the Fortran
and C++ source files into object code (.o files). After that, the make
program calls the MEX script, which in turn links all the object files
together into a single MEX file. If you didn't get any errors, then
you are ready to try out the bound-constrained solver in MATLAB. Note
that even if you didn't get any errors, there's still a possibility
that you didn't link the MEX file properly, in which case executing
the MEX file will cause MATLAB to crash. But there's only one way to
find out: the hard way.</p>

###Credits

Developed by [Peter Carbonetto](http://www.cs.ubc.ca/spider/pcarbo)
Dept. of Human Genetics
University of Chicago

###Footnotes

1. Ciyou Zhu, Richard H. Byrd, Peihuang Lu and Jorge Nocedal
(1997). Algorithm 778: L-BFGS-B: Fortran subroutines for large-scale
bound-constrained optimization. *ACM Transactions on Mathematical
Software* 23(4): 550-560.

2. [Another MATLAB interface](http://www.cs.toronto.edu/~liam/software.shtml)
for the L-BFGS-B routines has been developed by Liam Stewart at the
University of Toronto.

3. Willi Hock and Klaus Schittkowski (1981). *Test Examples for
Nonlinear Programming Codes.* Lecture Notes in Economics and
Mathematical Systems, Vol. 187, Springer-Verlag.

4. David M. Blei, Andrew Y. Ng, Michael I. Jordan (2003). Latent
Dirichlet allocation. *Journal of Machine Learning Research*
Vol3: 993-1022.

5. Tom L. Griffiths and Mark Steyvers (2004). Finding scientific
topics. *Proceedings of the National Academy of Sciences* 101:
5228-5235.
