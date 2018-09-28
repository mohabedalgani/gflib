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


function kv = kernelvalue(trainx, trainy, str, num)
len=length(str);
value=[];
for i=len:-1:1
    numbers=strsplit(num{i},'.');
    if strcmp(numbers{1},'0')
        if strcmp(str{i},'x')
            value{i}=trainx;
        else
            value{i}=trainy;
        end
    else        
        x1=value{str2num(numbers{1})};
        x2=value{str2num(numbers{2})};        
        if strcmp(str{i},'Plus_s')            
            value{i}=Plus_s(x1,x2);
        elseif strcmp(str{i},'Minus_s')
            value{i}=Minus_s(x1,x2);
        elseif strcmp(str{i},'Multi_s')    
            value{i}=Multi_s(x1,x2);
        elseif strcmp(str{i},'Plus_v')
            value{i}=Plus_v(x1,x2);      
        elseif strcmp(str{i},'Minus_v')   
            value{i}=Minus_v(x1,x2);           
        elseif strcmp(str{i},'Sine')
            value{i}=Sine(x1,x2);
        elseif strcmp(str{i},'Cosine')
            value{i}=Cosine(x1,x2);
        elseif strcmp(str{i},'Tanh')
            value{i}=Tanh(x1,x2);
        elseif strcmp(str{i},'Log')    
            value{i}=Log(x1,x2);
        end
    end
end
kv=value{1};