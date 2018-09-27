%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This file is part of GFLIB toolbox 
%   First Version Sept. 2018 
%   Copyright (C) 20016-2018 Mohd A. Mezher (mohabedalgani@gmail.com)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function value=Minus_s(x1,x2)
if isscalar(x1) && isscalar(x2)
    value=abs(x1-x2);
elseif  ~isscalar(x1) && ~isscalar(x2)
    value=norm(x1-x2);
elseif isscalar(x1) && ~isscalar(x2)
    tmp=zeros(length(x2),1);
    tmp(1)=x1;    
    value=norm(tmp-x2);
else
    tmp=zeros(length(x1),1);
    tmp(1)=x2; 
    value=norm(tmp-x1);
end                         