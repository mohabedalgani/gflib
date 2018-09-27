%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This file is part of GFLIB toolbox 
%   First Version Sept. 2018 
%   Copyright (C) 20016-2018 Mohd A. Mezher (mohabedalgani@gmail.com)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function value=Plus_v(x1,x2)
if isscalar(x1) && isscalar(x2)
    value=abs(x1+x2);
elseif  ~isscalar(x1) && ~isscalar(x2)
    value=x1+x2;
elseif isscalar(x1) && ~isscalar(x2)
    x2(1)=x2(1)+x1;
    value=x2;
else
    x1(1)=x1(1)+x2;
    value=x1;
end         