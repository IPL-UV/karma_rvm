%
% KERNEL ARMA for RVM
% Version 1.1 [20-Feb-2006]
%
% 
%  Nonlinear system identification with composite relevance vector machines 
%  Camps-Valls, G. and Mart�nez-Ram�n, M. and Rojo-�lvarez, J.L. and Mu�oz-Mar�, J. 
%  IEEE Signal Processing Letters 14 (4):279-282, 2007
%
%  A unified SVM framework for signal estimation 
%  Rojo-�lvarez, J.L. and Mart�nez-Ram�n, M. and Mu�oz-Mar�, J. and Camps-Valls, G. 
%  Digital Signal Processing: A Review Journal 26 (1):1-20, 2014
%
% CONTENTS:
%
%	BuildData			-	Returns the training and test patterns from a signal given an order P and Delay=0 (initial conditions).
%	BuildKernels		-	Builds the kernel matrices as a function of a given method ('stack','2k','4k','stack+2k','stack+4k')
%	ComputeResults		-	Computes different accuracy/bias measurements from an actual and predicted signals.
%	Demo      			-	Script demonstrating the training of KARMA methods in a given problem with fixed free parameters.
%	kernelmatrix		-	Builds the kernel matrix for a given method. At present, only RBF kernels.
%	TrainKernel			-	Trains a kernel matrix and returns the test outputs, nMSE, and model characteristics.
%
% Copyright (c) 2006
% Jordi Mu�oz-mar�, Gustavo Camps-Valls, Manel Mart�nez-Ram�n, Jos� L. Rojo-�lvarez
%
