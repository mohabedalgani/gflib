%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This file is part of GFLIB toolbox 
%   First Version Sept. 2018 
%   Copyright (C) 20016-2018 Mohd A. Mezher (mohabedalgani@gmail.com)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function fitness=calcfitness(pop,params)
%This function calculates fitness
%declare global variable 'ind' for Kernel Function in fitcsvm
global ind
global models
global trainX
global trainY
models=[];
if strcmp(params.type,'binary')  %in case of binary classification    
    %reading data
    if strcmp(params.data, 'spam.txt')
        M = dlmread(fullfile('data/binary',params.data));
        shape = size(M);
        randorder=randperm(shape(1));        
        tmpX = M(1:randorder(500),1:shape(2)-1);
        tmpY = M(1:randorder(500),shape(2));        
        classnames = [1 0];
    elseif strcmp(params.data, 'german credit.txt')
        M = dlmread(fullfile('data/binary',params.data));
        shape = size(M);
        tmpX = M(:,1:shape(2)-1);
        tmpY = M(:,shape(2));
        classnames = [1 2];
    elseif strcmp(params.data, 'logic_6_multiplexer.txt') || strcmp(params.data, 'odd_7_parity.txt') || strcmp(params.data, 'odd_3_parity.txt')
        M = dlmread(fullfile('data/binary',params.data));
        shape = size(M);
        tmpX = M(:,1:shape(2)-1);
        tmpY = M(:,shape(2));
        classnames = [1 0];
    elseif strcmp(params.data, 'credit approval.txt')
        M = importdata(fullfile('data/binary',params.data));      
        N = {};
        k = 0;
        for i = 1 : length(M)
            s = strsplit(M{i,1},',');           
            flag = 0;
            for j = 1 : length(s)
                if strcmp(s(j),'?')                    
                    flag = 1;
                    break;
                end
            end
            if flag == 0
                k = k + 1;
                N{k} = M{i,1};
            end
        end     
        
        P = [];
        for i = 1 : length(N)
            s = strsplit(N{i},',');           
            b = [];
            for j = 1 : length(s)
                b = [b s(j)];
            end
            P = [P; b];
        end            
        Q = [];
        shape = size(P);
        for i = 1 : shape(2)
            if isnan(str2double(P(1,i)))
                c = categorical(P(:,i));        
                n = grp2idx(c);
                Q = [Q n];
            else                
                Q = [Q str2double(P(:,i))];
            end
        end    
        tmpX = Q(:,1:shape(2)-1);
        tmpY = Q(:,shape(2));
        classnames = [1 2];
    else
        [tmpY, tmpX]=libsvmread(fullfile('data/binary',params.data));    
        classnames = [1 -1];
    end
    
    [N D] = size(tmpX);
    randorder=randperm(N);
    X=[];
    Y=ones(N,1);
    for i=1:N
        Y(i)=tmpY(randorder(i));
        X=[X;tmpX(randorder(i),:)];
    end    
    
    trainlen=ceil(N*0.75); 
    trainIndex = zeros(N,1); trainIndex(1:trainlen) = 1;
    testIndex = zeros(N,1); testIndex(trainlen+1:N) = 1;
    trainX = X(trainIndex==1,:);
    trainY = Y(trainIndex==1,:);
    testX = X(testIndex==1,:);
    testY = Y(testIndex==1,:);     
    
    trainX=full(trainX);    
    testX=full(testX);    
    
    for i=1:params.popsize    
        ind=pop(i);        
        SVMModel=fitcsvm(trainX,trainY,'KernelFunction','kernel','ClassNames',classnames,'Standardize',true);                        
        label = predict(SVMModel,testX);      
        models{i} = SVMModel;
        p=0;
        for j=1:length(label)
            if testY(j)==label(j)
                p=p+1;
            end
        end
        fitness(i)=p/length(label)*100; %percent         
    end
elseif strcmp(params.type,'multi')    
    %reading data
    if strcmp(params.data, 'zoo.txt')
        M = importdata(fullfile('data/multi',params.data));
        M = M.data;
        shape = size(M);
        tmpX = M(:,1:shape(2)-1);
        tmpY = M(:,shape(2));
        classnames = [1 2 3 4 5 6 7];
    else
        [tmpY, tmpX]=libsvmread(fullfile('data/multi',params.data));    
        classnames = [1 2 3];
    end    
    [N D] = size(tmpX);
    randorder=randperm(N);
    X=[];
    Y=ones(N,1);
    for i=1:N
        Y(i)=tmpY(randorder(i));
        X=[X;tmpX(randorder(i),:)];
    end    
    
    trainlen=ceil(N*0.75); 
    trainIndex = zeros(N,1); trainIndex(1:trainlen) = 1;
    testIndex = zeros(N,1); testIndex(trainlen+1:N) = 1;
    trainX = X(trainIndex==1,:);
    trainY = Y(trainIndex==1,:);
    testX = X(testIndex==1,:);
    testY = Y(testIndex==1,:);   
    truelabel = trainY;
    
    trainX=full(trainX);    
    testX=full(testX);    
    
    for i=1:params.popsize    
        ind=pop(i);
        t=templateSVM('Standardize',1,'KernelFunction','kernel');
        SVMModel=fitcecoc(trainX,trainY,'Learners',t,'ClassNames',classnames,'CrossVal','on','KFold',params.crossval);
        label=predict(SVMModel.Trained{1},testX);
        p=0;
        for j=1:length(label)
            if testY(j)==label(j)
                p=p+1;
            end
        end
        fitness(i)=p/length(label)*100; %percent         
    end
elseif strcmp(params.type,'regress')
    %reading data
    [tmpY, tmpX]=libsvmread(fullfile('data/regress',params.data));    
    [N D] = size(tmpX);
    randorder=randperm(N);
    X=[];
    Y=ones(N,1);
    for i=1:N
        Y(i)=tmpY(randorder(i));
        X=[X;tmpX(randorder(i),:)];
    end    
    
    trainlen=ceil(N*0.75); 
    trainIndex = zeros(N,1); trainIndex(1:trainlen) = 1;
    testIndex = zeros(N,1); testIndex(trainlen+1:N) = 1;
    trainX = X(trainIndex==1,:);
    trainY = Y(trainIndex==1,:);
    testX = X(testIndex==1,:);
    testY = Y(testIndex==1,:);   
    
    trainX=full(trainX);    
    testX=full(testX);    
    
    fitsum = 0;
    for i=1:params.popsize    
        ind=pop(i);
        SVRModel=fitrsvm(trainX,trainY,'Standardize',true,'KernelFunction','kernel','CrossVal','on','KFold',params.crossval);
        yfit=predict(SVRModel.Trained{1},testX);
        
        p=0;
        for j=1:length(yfit)
            p=p+(yfit(j)-testY(j))^2;
        end
        p = p / length(yfit);
        fitness(i)=-p;        
    end    
end