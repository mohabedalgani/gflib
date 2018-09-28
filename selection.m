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