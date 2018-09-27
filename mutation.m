%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This file is part of GFLIB toolbox 
%   First Version Sept. 2018 
%   Copyright (C) 20016-2018 Mohd A. Mezher (mohabedalgani@gmail.com)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function newind=mutation(orgind,params)
newind=struct;
newind.chromnum=orgind.chromnum;
len=length(orgind.chromstr);
if rand<params.mutprob
    if strcmp(orgind.chromstr{1},'Plus_s')
        newind.chromstr{1}='Minus_s';
    else
        newind.chromstr{1}='Plus_s';
    end
else
    newind.chromstr{1}=orgind.chromstr{1};
end
for i=2:len
    if rand<params.mutprob
        numbers=strsplit(orgind.chromnum{i},'.');
        if ~strcmp(numbers{1},'0')
            newind.chromstr{i}=params.oplist{intrand(1,4)};
        else
            newind.chromstr{i}=params.oplist{intrand(5,6)};
        end
    else
        newind.chromstr{i}=orgind.chromstr{i};
    end
end
newind.tree=tree(newind.chromstr{1});
len=length(newind.chromstr);
pos=1;
node(1)=1;
while pos<=len
    numbers=strsplit(newind.chromnum{pos},'.');
    if ~strcmp(numbers{1},'0')
        [newind.tree node(str2num(numbers{1}))]=newind.tree.addnode(node(pos),newind.chromstr{str2num(numbers{1})});
        [newind.tree node(str2num(numbers{2}))]=newind.tree.addnode(node(pos),newind.chromstr{str2num(numbers{2})});
    end
    pos=pos+1;
end    