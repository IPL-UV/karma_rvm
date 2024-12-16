%
% KERNELMATRIX
%	This function computes the kernel matrix from sample data	
% 	Version for fast matrix form of rbf
%
% Code by Steve Gunn.
% ... and by JLRojo, 2005(c) 
% jlrojo@tsc.uc3m.es
%

function H = kernelmatrix(ker,x1,x2,sigmay)

% In column form:
x1=x1';x2=x2';
  
if(size(x1,2)==1)
    N1=size(x1,1);
    N2=size(x2,1);
    H = zeros(N1,N2);
    for i=1:N1
        H(i,:) = (exp(-(1/2/(sigmay^2))*(x2-ones(N2,1)*x1(i,:))'.*(x2-ones(N2,1)*x1(i,:))'));
    end
else
    N1=size(x1,1);
    N2=size(x2,1);
    H = zeros(N1,N2);
    for i=1:N1
        H(i,:) = exp(-(1/2/(sigmay^2))*sum((x2-ones(N2,1)*x1(i,:))'.*(x2-ones(N2,1)*x1(i,:))'));
    end
end
