%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This file is part of GFLIB toolbox 
%   First Version Sept. 2018 
%   Copyright (C) 20016-2018 Mohd A. Mezher (mohabedalgani@gmail.com)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function value=Tanh(x1,x2)
if isscalar(x1) && isscalar(x2)
    value=(tanh(x1)*tanh(x2))^2;
elseif  ~isscalar(x1) && ~isscalar(x2)
    value=sum(tanh(x1).*tanh(x2));     
elseif isscalar(x1) && ~isscalar(x2)
    tmp=zeros(length(x2),1);
    tmp(1)=tanh(x1); 
    tmp=tmp+tanh(x2);
    value=sum(tmp.^2);    
else
    tmp=zeros(length(x1),1);
    tmp(1)=tanh(x2); 
    tmp=tmp+tanh(x1);
    value=sum(tmp.^2);  
end            