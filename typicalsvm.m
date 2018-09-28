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

function mse = typicalsvm(ptype,ktype,data)
if strcmp(ptype,'binary')
    if strcmp(data, 'spam.txt')
        M = dlmread(fullfile('data/binary',data));
        shape = size(M);
        randorder=randperm(shape(1));        
        tmpX = M(1:randorder(500),1:shape(2)-1);
        tmpY = M(1:randorder(500),shape(2));
        classnames = [1 0];
    elseif strcmp(data, 'german credit.txt')
        M = dlmread(fullfile('data/binary',data));
        shape = size(M);
        tmpX = M(:,1:shape(2)-1);
        tmpY = M(:,shape(2));
        classnames = [1 2];
    elseif strcmp(data, 'logic_6_multiplexer.txt') || strcmp(data, 'odd_7_parity.txt') || strcmp(data, 'odd_3_parity.txt')
        M = dlmread(fullfile('data/binary',data));
        shape = size(M);
        tmpX = M(:,1:shape(2)-1);
        tmpY = M(:,shape(2));
        classnames = [1 0];
    elseif strcmp(data, 'credit approval.txt')
        M = importdata(fullfile('data/binary',data));      
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
        [tmpY, tmpX]=libsvmread(fullfile('data/binary',data));    
        classnames = [1 -1];
    end
    
    [N D]=size(tmpX);
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
    SVMModel=fitcsvm(trainX,trainY,'KernelFunction',ktype,'ClassNames',classnames,'Standardize',true);
    %to test using Matlab loss function
    L = loss(SVMModel,testX,testY);
    fprintf("the value of loss:%d ", L);
    label=predict(SVMModel,testX);
    p=0;
    for j=1:length(label)
        if testY(j)==label(j)
            p=p+1;
        end
    end
    fitness=p/length(label)*100;
    mse = (100 - fitness) / 100;
    s=sprintf("Accuracy : %f %%\n",fitness);
    disp(s);
elseif strcmp(ptype,'multi')
    if strcmp(data, 'zoo.txt')
%          classes = {};
%          classes{1} = {'aardvark', 'antelope', 'bear', 'boar', 'buffalo', 'calf', ...
%                     'cavy', 'cheetah', 'deer', 'dolphin', 'elephant', ...
%                     'fruitbat', 'giraffe', 'girl', 'goat', 'gorilla', 'hamster', ...
%                     'hare', 'leopard', 'lion', 'lynx', 'mink', 'mole', 'mongoose', ...
%                     'opossum', 'oryx', 'platypus', 'polecat', 'pony', ...
%                     'porpoise', 'puma', 'pussycat', 'raccoon', 'reindeer', ...
%                     'seal', 'sealion', 'squirrel', 'vampire', 'vole', 'wallaby','wolf'};
%          classes{2} = {'chicken', 'crow', 'dove', 'duck', 'flamingo', 'gull', 'hawk', ...
%                     'kiwi', 'lark', 'ostrich', 'parakeet', 'penguin', 'pheasant', ...
%                     'rhea', 'skimmer', 'skua', 'sparrow', 'swan', 'vulture', 'wren'};
%          classes{3} = {'pitviper', 'seasnake', 'slowworm', 'tortoise', 'tuatara'};
%          classes{4} = {'bass', 'carp', 'catfish', 'chub', 'dogfish', 'haddock', ...
%                     'herring', 'pike', 'piranha', 'seahorse', 'sole', 'stingray', 'tuna'};
%          classes{5} = {'frog', 'newt', 'toad'};
%          classes{6} = {'flea', 'gnat', 'honeybee', 'housefly', 'ladybird', 'moth', 'termite', 'wasp'};
%          classes{7} = {'clam', 'crab', 'crayfish', 'lobster', 'octopus', ...
%                     'scorpion', 'seawasp', 'slug', 'starfish', 'worm'}; 
%          
%          M = importdata(fullfile('data/multi',data));
%          names = M.textdata; 
%          newnames = [];
%          for i = 1 : length(names)
%              flag = 0;
%              for j = 1 : 7
%                  a = classes{j};                 
%                  for k = 1 : length(classes{j})
%                      if strcmp(names(i), a(k))
%                          flag = 1;
%                          break;
%                      end
%                  end
%                  if flag == 1
%                      break;
%                  end
%              end
%              newnames = [newnames; j];
%          end         
%          newnames
        M = importdata(fullfile('data/multi',data));
        M = M.data;
        shape = size(M);
        tmpX = M(:,1:shape(2)-1);
        tmpY = M(:,shape(2));
        classnames = [1 2 3 4 5 6 7];
    else
        [tmpY, tmpX]=libsvmread(fullfile('data/multi',data));    
        classnames = [1 2 3];
    end
    
    [N D]=size(tmpX);
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
    t=templateSVM('Standardize',1,'KernelFunction',ktype);
    SVMModel=fitcecoc(trainX,trainY,'Learners',t,'ClassNames',classnames);
    label=predict(SVMModel,testX);
    p=0;
    for j=1:length(label)
        if testY(j)==label(j)
            p=p+1;
        end
    end
    fitness=p/length(label)*100;
    mse = (100 - fitness) / 100;
    s=sprintf("Accuracy : %f %%\n",fitness);
    disp(s);
elseif strcmp(ptype,'regress')
    [tmpY, tmpX]=libsvmread(fullfile('data/regress',data));        
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
    SVRModel=fitrsvm(trainX,trainY,'Standardize',true,'KernelFunction',ktype);
    yfit=predict(SVRModel,testX);
    p=0;
    for j=1:length(yfit)
        p=p+(yfit(j)-testY(j))^2;
    end
    p=p/length(yfit);
    fitness=-p;
    s=sprintf("MSE : %f \n",-fitness);
    disp(s);
end