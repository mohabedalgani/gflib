%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This file is part of GFLIB toolbox 
%   First Version Sept. 2018 
%   Copyright (C) 20016-2018 Mohd A. Mezher (mohabedalgani@gmail.com)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function newpop=selection(orgpop,fitness)
fitness_sum=0;
maxfit=max(fitness);
for i=1:length(fitness)
    if maxfit==fitness(i)
        maxnum=i;
        break;
    end
end
for i=1:length(fitness)
    fitness_sum=fitness_sum+fitness(i);
end
for i=1:length(fitness)
    if i==maxnum
        newpop(i)=orgpop(i);
    else
        value=rand*fitness_sum;
        if value<fitness(i)
            newpop(i)=orgpop(i);
        else
            newpop(i)=orgpop(maxnum);
        end
    end
end