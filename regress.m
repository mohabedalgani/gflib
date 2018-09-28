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

clear
clc
close all
warning off
s=sprintf("Running regression ...\n\n");
disp(s);
pause(0.1);

addpath('libsvm-3.22/matlab');
addpath('@tree');
addpath('data/regress'); %dataset path for binary

params.type='regress'; %problem type
params.data='housing_scale.txt';  %dataset 
params.kernel='gf'; %rbf,linear,polynomial,gf
params.mutprob=0.1; %mutation probability
params.crossprob=0.5; %crossover probability
params.maxgen=2; %max generation
params.popsize=5; %population size
params.crossval=5;
% params.oplist={'Plus_s','Minus_s','Multi_s','Plus_v','Minus_v','x','y'};    %operators and operands
params.oplist={'Plus_s','Minus_s','Plus_v','Minus_v','Sine','Cosine','Tanh','Log','x','y'};    %operators and operands

s=sprintf("Data Set : data/regress/%s\n",params.data);
disp(s);
pause(0.1);

%For MSE
kernels = {'polynomial', 'rbf', 'linear', 'gf'};
totalmse = [];

for i = 1 : 10
    temp = [];
    clc
    close all
    for j = 1 : 4
        params.kernel = kernels{1,j};
        s=sprintf("SVM Kernel : %s\n",params.kernel);
        disp(s);       
        pause(0.1);
        if strcmp(params.kernel,'gf')
            s=sprintf("Max Generation : %d\n",params.maxgen);
            disp(s);
            pause(0.1);
            s=sprintf("Population Size : %d\n",params.popsize);
            disp(s);
            pause(0.1);
            s=sprintf("CrossOver Probability : %f\n",params.crossprob);
            disp(s);
            pause(0.1);
            s=sprintf("Mutation Probability : %f\n\n",params.mutprob);
            disp(s);
            pause(0.1);
            pop=inipop(params); %initial population
            mse = genpop(pop,params); %generation
        else
            mse = typicalsvm(params.type,params.kernel,params.data);
        end
        temp = [temp mse];
        s = sprintf("\n");
        disp(s);
    end
    totalmse = [totalmse; temp];
end
boxplot([totalmse(:,1),totalmse(:,2),totalmse(:,3),totalmse(:,4)],'Labels',{'Polynomial','Rbf','Linear','Gf'});
title('MSE for each svm kernel');
xlabel('svm kernel');
ylabel('Test Error Rate');