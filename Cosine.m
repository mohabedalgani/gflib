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


function value=Cosine(x1,x2)
if isscalar(x1) && isscalar(x2)
    value=(cos(x1)*cos(x2))^2;
elseif  ~isscalar(x1) && ~isscalar(x2)
    value=sum(cos(x1).*cos(x2));     
elseif isscalar(x1) && ~isscalar(x2)
    tmp=zeros(length(x2),1);
    tmp(1)=cos(x1); 
    tmp=tmp+cos(x2);
    value=sum(tmp.^2);        
else
    tmp=zeros(length(x1),1);
    tmp(1)=cos(x2); 
    tmp=tmp+cos(x1);
    value=sum(tmp.^2);  
end            