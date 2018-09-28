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


function mse = genpop(pop,params)
global models
global trainX
global trainY
%calculate fitness
s=sprintf("Calculate Fitness Before Generation ...\n");
disp(s);
pause(0.1);
fitness=calcfitness(pop,params);

s=sprintf("Initial Fitness\n");
disp(s);
pause(0.1);
fitness
s=sprintf("\n");
disp(s);
pause(0.1);

%figure 1 : Fitness
f1=figure;
hold on;
xlim([0 params.maxgen]);
xticks(0:1:params.maxgen);
xlabel('generation');
if strcmp(params.type,'regress')
    ylabel('MSE negative value');
else
    ylabel('fitness/accuracy %');
    ylim([0 100]);
end    
title('Fitness');

old_maximum_fit=max(fitness);   % maximum fitness
old_average_fit=mean(fitness);  % average fitness
old_median_fit=median(fitness); % median fitness
old_std_fit=std(fitness);       % standard deviation
old_max_fit=old_maximum_fit;

for i=1:length(fitness)
    if old_max_fit==fitness(i)
        max_num=i;
        max_ind=pop(i);
        break;
    end
end

plot([0 0],[old_maximum_fit old_maximum_fit],'Color','b','LineWidth',1,'Marker','o');
plot([0 0],[old_average_fit old_average_fit],'Color','y','Marker','o');
plot([0 0],[old_median_fit old_median_fit],'Color','g','Marker','o');
plot([0 0],[old_average_fit-old_std_fit old_average_fit-old_std_fit],'Color','r','LineStyle',':','Marker','o');
plot([0 0],[old_average_fit+old_std_fit old_average_fit+old_std_fit],'Color','r','LineStyle',':','Marker','o');
plot([0 0],[old_max_fit old_max_fit],'Color','b','LineWidth',2,'Marker','o');

s1=sprintf("maximum:%f", old_maximum_fit);
s2=sprintf("average:%f", old_average_fit);
s3=sprintf("median:%f", old_median_fit);
s4=sprintf("avg-std:%f", old_average_fit - old_std_fit);
s5=sprintf("avg+std:%f", old_average_fit + old_std_fit);
s6=sprintf("bestsofar:%f", old_max_fit);
legend(s1,s2,s3,s4,s5,s6);
hold off;

%figure 2 : Structure Complexity
f2=figure;
hold on;
xlim([0 params.maxgen]);
xticks(0:1:params.maxgen);
xlabel('generation');
ylabel('tree depth/size');
title('Structure Complexity');

for i=1:length(pop)
    treenodes(i)=length(pop(i).chromnum);
    treedepths(i)=1;
    childnum=treenodes(i);
    for j=treenodes(i):-1:1
        numbers=strsplit(pop(i).chromnum{j},'.');
        if ~strcmp(numbers{1},'0') && (strcmp(numbers{1},num2str(childnum)) || strcmp(numbers{2},num2str(childnum)))
            treedepths(i)=treedepths(i)+1;
            childnum=j;
        end
    end
end    

old_maximum_depth=max(treedepths);
old_max_depth=treedepths(max_num);
old_max_size=treenodes(max_num);

plot([0 0],[old_maximum_depth old_maximum_depth],'Color','m','Marker','*');
plot([0 0],[old_max_depth old_max_depth],'Color','y','Marker','*');
plot([0 0],[old_max_size old_max_size],'Color','g','Marker','*');

s1=sprintf("maximum depth:%d", old_maximum_depth);
s2=sprintf("bestsofar depth:%d", old_max_depth);
s3=sprintf("bestsofar size:%d", old_max_size);
legend(s1,s2,s3);
hold off;

%figure 3 : Population Diversity
f3=figure;
hold on;
xlim([0 params.maxgen]);
ylim([0 100]);
xticks(0:1:params.maxgen);
xlabel('generation');
ylabel('fitness distribution');
title('Population Diversity');

xgen=zeros(1,length(fitness));
plot(xgen,fitness,'Color','b','Marker','.');
hold off;

%figure 4 : Accuracy versus Complexity
f4=figure;
hold on;
xlim([0 params.maxgen]);
ylim([0 100]);
xticks(0:1:params.maxgen);
xlabel('generation');
ylabel('fitness, nodes');
title('Accuracy versus Complexity');

plot(0, old_max_fit, 'Color','b','Marker','.');
plot(0, old_max_size, 'Color','r','Marker','.');

s1=sprintf("fitness");
s2=sprintf("nodes");
legend(s1,s2);
hold off

s=sprintf("Progress in Generation ...\n");
disp(s);
pause(0.1);

%generation
for i=1:params.maxgen       
    s=sprintf("Genration %d\n",i);
    disp(s);
    pause(0.1);
    
    %selection
    s=sprintf("Selection in generation %d\n",i);
    disp(s);
    pause(0.1);
    pop=selection(pop,fitness);  
    
%     %randomize order
%     randorder=randperm(length(pop));    
%     for j=1:length(pop)
%         tmp(j)=pop(randorder(j));
%     end           
%     pop=tmp;
    
    %apply crossover to the first half part of population
    s=sprintf("Crossover in generation %d\n",i);
    disp(s);
    pause(0.1);
    
    j=1;
    while j<ceil(params.popsize/2)        
        [pop(j),pop(j+1)]=crossover(pop(j),pop(j+1),params.crossprob);        
        j=j+2;
    end
    
    %apply mutation to the second part of population
    s=sprintf("Mutation in generation %d\n",i);
    disp(s);
    pause(0.1);
    for j=ceil(params.popsize/2)+1:params.popsize
        pop(j)=mutation(pop(j),params);        
    end   
    
    %calculate fitness
    s=sprintf("Calculate fitness in generation %d\n",i);
    disp(s);
    pause(0.1);
    fitness=calcfitness(pop,params);
    %fitness
    
    new_maximum_fit=max(fitness);   % maximum fitness
    new_average_fit=mean(fitness);  % average fitness
    new_median_fit=median(fitness); % median fitness
    new_std_fit=std(fitness);       % standard deviation        
    
    for j=1:length(fitness)
        if new_maximum_fit==fitness(j)
            max_num=j;
            tmp_max_ind=pop(j);
            break;
        end
    end
    
    if new_maximum_fit > old_max_fit
        new_max_fit=new_maximum_fit;        
        max_ind=tmp_max_ind;
    else
        new_max_fit=old_max_fit;
        pop(max_num)=max_ind;  
    end
    
    for j=1:length(pop)
        treenodes(j)=length(pop(j).chromnum);
        treedepths(j)=1;
        childnum=treenodes(j);
        for k=treenodes(j):-1:1
            numbers=strsplit(pop(j).chromnum{k},'.');
            if ~strcmp(numbers{1},'0') && (strcmp(numbers{1},num2str(childnum)) || strcmp(numbers{2},num2str(childnum)))
                treedepths(j)=treedepths(j)+1;
                childnum=k;
            end
        end
    end    

    new_maximum_depth=max(treedepths);
    new_max_depth=treedepths(max_num);
    new_max_size=treenodes(max_num);    
    
    figure(f1);
    hold on;
    plot([i-1 i],[old_maximum_fit new_maximum_fit],'Color','b','LineWidth',1,'Marker','o');
    plot([i-1 i],[old_average_fit new_average_fit],'Color','y','Marker','o');
    plot([i-1 i],[old_median_fit new_median_fit],'Color','g','Marker','o');
    plot([i-1 i],[old_average_fit-old_std_fit new_average_fit-new_std_fit],'Color','r','LineStyle',':','Marker','o');
    plot([i-1 i],[old_average_fit+old_std_fit new_average_fit+new_std_fit],'Color','r','LineStyle',':','Marker','o');
    plot([i-1 i],[old_max_fit new_max_fit],'Color','b','LineWidth',2,'Marker','o');
    s1=sprintf("maximum:%f", new_maximum_fit);
    s2=sprintf("average:%f", new_average_fit);
    s3=sprintf("median:%f", new_median_fit);
    s4=sprintf("avg-std:%f", new_average_fit - old_std_fit);
    s5=sprintf("avg+std:%f", new_average_fit + old_std_fit);
    s6=sprintf("bestsofar:%f", new_max_fit);
    legend(s1,s2,s3,s4,s5,s6);
    hold off;
    
    figure(f2);
    hold on;   
    plot([i-1 i],[old_maximum_depth new_maximum_depth],'Color','m','Marker','*');
    plot([i-1 i],[old_max_depth new_max_depth],'Color','y','Marker','*');
    plot([i-1 i],[old_max_size new_max_size],'Color','g','Marker','*');
    s1=sprintf("maximum depth:%d", new_maximum_depth);
    s2=sprintf("bestsofar depth:%d", new_max_depth);
    s3=sprintf("bestsofar size:%d", new_max_size);
    legend(s1,s2,s3);
    hold off;
    
    figure(f3);
    hold on;
    xgen=i*ones(1,length(fitness));
    plot(xgen,fitness,'Color','b','Marker','.');
    hold off;
    
    figure(f4);
    hold on;
    plot([i-1 i],[old_maximum_fit new_maximum_fit],'Color','b','Marker','.');
    plot([i-1 i],[old_max_size new_max_size],'Color','r','Marker','.');
    s1=sprintf("fitness");
    s2=sprintf("nodes");
    legend(s1,s2);
    hold off;

    old_maximum_fit=new_maximum_fit;
    old_average_fit=new_average_fit;
    old_median_fit=new_median_fit;
    old_std_fit=new_std_fit;
    old_max_fit=new_max_fit;
    
    old_maximum_depth=new_maximum_depth;
    old_max_depth=new_max_depth;
    old_max_size=new_max_size;
  
    %if ~strcmp(params.type,'regress')
        s=sprintf("Max Fitness in gneration %d : %f %%\n\n",i,new_maximum_fit);
    %else
    %    s=sprintf("MSE in gneration %d : %f\n\n",i,new_maximum_fit);
    %end
    disp(s);
    pause(0.1);   
end

%display result after generation 
if ~strcmp(params.type,'regress')
    s=sprintf("Max Fitness(Accuracy) in all generations : %f %% \n",new_max_fit);   
    mse = (100 - new_max_fit) / 100;
else
    s=sprintf("MSE in all generations : %f \n",-new_max_fit);   
    mse = -new_max_fit;
end
disp(s);

%print best chromosome string
s=sprintf("Best Chromosome String : \n");
disp(s);
best_chromstr=max_ind.chromstr

%print best chromosome number
s=sprintf("Best Chromosome Number : \n");
disp(s);
best_chromnum=max_ind.chromnum

%plot expression tree
figure('Name','Best Expression Tree');
max_ind.tree.plot;

if strcmp(params.type,'binary')
    %plot roc curve
    Mdl = fitPosterior(models{max_num});
    [~, score] = resubPredict(Mdl);
    [X,Y,T,AUC] = perfcurve(trainY,(score(:,1)),1);
    AUC
    figure('Name','ROC curve');
    plot(X,Y);
    xlabel('False positive rate');
    ylabel('True positive rate');
end