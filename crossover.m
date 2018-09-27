%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This file is part of GFLIB toolbox 
%   First Version Sept. 2018 
%   Copyright (C) 20016-2018 Mohd A. Mezher (mohabedalgani@gmail.com)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [child1,child2]=crossover(parent1,parent2,crossprob)
tmp1=struct;
tmp2=struct;
if rand<crossprob
    tmp1.chromstr=[];
    tmp2.chromnum=[];
    tmp1.chromstr=[];
    tmp2.chromnum=[];
    len=min(length(parent1.chromstr),length(parent2.chromstr));
    maxcrosspoint=2;
    for i=2:len
        if ~strcmp(parent1.chromnum{i},parent2.chromnum{i})
            maxcrosspoint=i;
            break;
        end
    end
    crosspoint=intrand(2,maxcrosspoint);
    for i=1:length(parent2.chromstr)
        if i<crosspoint
            tmp1.chromstr{i}=parent1.chromstr{i};
            tmp1.chromnum{i}=parent1.chromnum{i};
        else
            tmp1.chromstr{i}=parent2.chromstr{i};
            tmp1.chromnum{i}=parent2.chromnum{i};
        end
    end
    for i=1:length(parent1.chromstr)
        if i<crosspoint
            tmp2.chromstr{i}=parent2.chromstr{i};
            tmp2.chromnum{i}=parent2.chromnum{i};
        else
            tmp2.chromstr{i}=parent1.chromstr{i};
            tmp2.chromnum{i}=parent1.chromnum{i};
        end
    end
    tmp1.tree=tree(tmp1.chromstr{1});
    len=length(tmp1.chromstr);
    pos=1;
    node(1)=1;
    while pos<=len
        numbers=strsplit(tmp1.chromnum{pos},'.');
        if ~strcmp(numbers{1},'0')
            [tmp1.tree node(str2num(numbers{1}))]=tmp1.tree.addnode(node(pos),tmp1.chromstr{str2num(numbers{1})});
            [tmp1.tree node(str2num(numbers{2}))]=tmp1.tree.addnode(node(pos),tmp1.chromstr{str2num(numbers{2})});
        end
        pos=pos+1;
    end    
    tmp2.tree=tree(tmp2.chromstr{1});
    len=length(tmp2.chromstr);
    pos=1;
    while pos<=len
        numbers=strsplit(tmp2.chromnum{pos},'.');
        if ~strcmp(numbers{1},'0')
            [tmp2.tree node(str2num(numbers{1}))]=tmp2.tree.addnode(pos,tmp2.chromstr{str2num(numbers{1})});
            [tmp2.tree node(str2num(numbers{2}))]=tmp2.tree.addnode(pos,tmp2.chromstr{str2num(numbers{2})});
        end
        pos=pos+1;
    end      
else
    tmp1=parent1;
    tmp2=parent2;
end
child1=tmp1;
child2=tmp2;