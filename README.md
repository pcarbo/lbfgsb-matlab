# A MATLAB interface for L-BFGS-B

###Overview

<p>L-BFGS-B is a collection of Fortran 77 routines for solving
large-scale nonlinear optimization problems with bound constraints on
the variables. One of the key features of the nonlinear solver is that
knowledge of the Hessian is not required; the solver computes search
directions by keeping track of a quadratic model of the objective
function with a limited-memory BFGS (Broyden-Fletcher-Goldfarb-Shanno)
approximation to the Hessian (1). The algorithm was developed by Ciyou
Zhu, Richard Byrd and Jorge Nocedal. For more information, go to the
[original distribution site](http://www.ece.northwestern.edu/~nocedal/lbfgsb.html) for the L-BFGS-B software package.

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
Mathematical Systems, Vol. 187, Springer-Verlag.</p>

4. David M. Blei, Andrew Y. Ng, Michael I. Jordan (2003). Latent
Dirichlet allocation. *Journal of Machine Learning Research*
Vol3: 993-1022.

5. Tom L. Griffiths and Mark Steyvers (2004). Finding scientific
topics. *Proceedings of the National Academy of Sciences* 101:
5228-5235.
