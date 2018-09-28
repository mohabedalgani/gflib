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

function value=Minus_v(x1,x2)
if isscalar(x1) && isscalar(x2)
    value=abs(x1-x2);
elseif  ~isscalar(x1) && ~isscalar(x2)
    value=x1-x2;
elseif isscalar(x1) && ~isscalar(x2)
    x2(1)=x2(1)-x1;
    value=x2;
else
    x1(1)=x1(1)-x2;
    value=x1;
end          