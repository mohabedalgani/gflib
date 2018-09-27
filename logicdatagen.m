%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This file is part of GFLIB toolbox 
%   First Version Sept. 2018 
%   Copyright (C) 20016-2018 Mohd A. Mezher (mohabedalgani@gmail.com)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This script generates logic synthesis data
%6-multiplexer, odd-3-parity, odd-5-parity

%%6-multiplexer
inputs = randi([0, 1], [64, 6]);
output = [];
for i = 1 : 64
    if inputs(i,1) == 0 && inputs(i,2) == 0
        output = [output; inputs(i,3)];
    elseif inputs(i,1) == 0 && inputs(i,2) == 1
        output = [output; inputs(i,4)];
    elseif inputs(i,1) == 1 && inputs(i,2) == 0
        output = [output; inputs(i,5)];
    elseif inputs(i,1) == 1 && inputs(i,2) == 1
        output = [output; inputs(i,6)];
    end
end

data = [inputs output];
dlmwrite('data/binary/logic_6_multiplexer.txt', data);

%%odd-3-parity
data = [];
for i = 0 : 7
    b = de2bi(i,3);    
    n = 0;
    for j = 1 : 3
        if b(j) == 1
            n = n + 1;
        end
    end   
    if n == 1 || n == 3
        data = [data; b 1];
    else
        data = [data; b 0];
    end
end
dlmwrite('data/binary/odd_3_parity.txt', data);

%%odd-7-parity
data = [];
for i = 0 : 127
    b = de2bi(i,7);    
    n = 0;
    for j = 1 : 7
        if b(j) == 1
            n = n + 1;
        end
    end   
    if n == 1 || n == 3 || n == 5 || n == 7
        data = [data; b 1];
    else
        data = [data; b 0];
    end
end
dlmwrite('data/binary/odd_7_parity.txt', data);
