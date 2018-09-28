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


function pop = inipop(params)
%This function generates initial population randomly.
s=sprintf("Initial Population ...\n");
disp(s);
if strcmp(params.type,'binary')  %in case of binary classification  
    for i=1:params.popsize
        pop(i).chromstr=[];
        pop(i).chromnum=[];
        pop(i).chromstr{1}=params.oplist{intrand(1,2)}; %root operator must be scalar                
        pop(i).tree=tree(pop(i).chromstr{1});
        node(1)=1;
        oplimit=3; 
        opcount=0;  
        count=1;
        pos=1;            
        len=1;        
        while count~=0
            if ~strcmp(pop(i).chromstr{pos},'x') && ~strcmp(pop(i).chromstr{pos},'y')
                count=count+2;
                opcount=opcount+1;
                pop(i).chromnum{pos}=strcat(num2str(len+1),'.',num2str(len+2));
                if opcount>oplimit
                    pop(i).chromstr{len+1}=params.oplist{intrand(6,7)};
                    pop(i).chromstr{len+2}=params.oplist{intrand(6,7)};                                        
                else
                    pop(i).chromstr{len+1}=params.oplist{intrand(1,7)};
                    pop(i).chromstr{len+2}=params.oplist{intrand(1,7)};
                    
                end                
                [pop(i).tree node(len+1)]=pop(i).tree.addnode(node(pos),pop(i).chromstr{len+1});
                [pop(i).tree node(len+2)]=pop(i).tree.addnode(node(pos),pop(i).chromstr{len+2});
                len=len+2;
            else
                pop(i).chromnum{pos}=strcat('0.',num2str(pos));
            end
            pos=pos+1;
            count=count-1;            
        end
%         s=sprintf('Individual %d\n',i);
%         disp(s);
%         chromosome_string=pop(i).chromstr
%         chromosome_number=pop(i).chromnum
%         s=sprintf('\n\n');
%         disp(s);
    end        
elseif strcmp(params.type,'multi')
    for i=1:params.popsize
        pop(i).chromstr=[];
        pop(i).chromnum=[];
        pop(i).chromstr{1}=params.oplist{intrand(1,2)}; %root operator must be scalar                
        pop(i).tree=tree(pop(i).chromstr{1});
        node(1)=1;
        oplimit=3; 
        opcount=0;  
        count=1;
        pos=1;            
        len=1;        
        while count~=0
            if ~strcmp(pop(i).chromstr{pos},'x') && ~strcmp(pop(i).chromstr{pos},'y')
                count=count+2;
                opcount=opcount+1;
                pop(i).chromnum{pos}=strcat(num2str(len+1),'.',num2str(len+2));
                if opcount>oplimit
                    pop(i).chromstr{len+1}=params.oplist{intrand(9,10)};
                    pop(i).chromstr{len+2}=params.oplist{intrand(9,10)};                                        
                else
                    pop(i).chromstr{len+1}=params.oplist{intrand(1,10)};
                    pop(i).chromstr{len+2}=params.oplist{intrand(1,10)};
                    
                end                
                [pop(i).tree node(len+1)]=pop(i).tree.addnode(node(pos),pop(i).chromstr{len+1});
                [pop(i).tree node(len+2)]=pop(i).tree.addnode(node(pos),pop(i).chromstr{len+2});
                len=len+2;
            else
                pop(i).chromnum{pos}=strcat('0.',num2str(pos));
            end
            pos=pos+1;
            count=count-1;            
        end                
    end    
elseif strcmp(params.type,'regress')
    for i=1:params.popsize
        pop(i).chromstr=[];
        pop(i).chromnum=[];
        pop(i).chromstr{1}=params.oplist{intrand(1,2)}; %root operator must be scalar                
        pop(i).tree=tree(pop(i).chromstr{1});
        node(1)=1;
        oplimit=3; 
        opcount=0;  
        count=1;
        pos=1;            
        len=1;        
        while count~=0
            if ~strcmp(pop(i).chromstr{pos},'x') && ~strcmp(pop(i).chromstr{pos},'y')
                count=count+2;
                opcount=opcount+1;
                pop(i).chromnum{pos}=strcat(num2str(len+1),'.',num2str(len+2));
                if opcount>oplimit
                    pop(i).chromstr{len+1}=params.oplist{intrand(9,10)};
                    pop(i).chromstr{len+2}=params.oplist{intrand(9,10)};                                        
                else
                    pop(i).chromstr{len+1}=params.oplist{intrand(1,10)};
                    pop(i).chromstr{len+2}=params.oplist{intrand(1,10)};
                    
                end                
                [pop(i).tree node(len+1)]=pop(i).tree.addnode(node(pos),pop(i).chromstr{len+1});
                [pop(i).tree node(len+2)]=pop(i).tree.addnode(node(pos),pop(i).chromstr{len+2});
                len=len+2;
            else
                pop(i).chromnum{pos}=strcat('0.',num2str(pos));
            end
            pos=pos+1;
            count=count-1;            
        end                
    end     
end