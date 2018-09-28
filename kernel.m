%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This file is part of GFLIB toolbox 
%   First Version Sept. 2018 
%  
%   Cite this project as:
%   Mezher M., Abbod M. (2011) Genetic Folding: A New Class of Evolutionary Algorithms. 
%   In: Bramer M., Petridis M., Hopgood A. (eds) Research and Development in Intelligent Systems XXVII. 
%   SGAI 2010. Springer, London
%
%   Copyright (C) 20011-2018 Mohd A. Mezher (mohabedalgani@gmail.com)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function G = kernel(U,V)
global ind
m=size(U,1);
n=size(V,1);
for i=1:m
    for j=1:n
        G(i,j)=kernelvalue(U(i,:),V(j,:),ind.chromstr,ind.chromnum);
    end
end