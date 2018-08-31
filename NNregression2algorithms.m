clear; 
load TTE

Nav=1;
No_Points=20; Multi=1;
EEE=zeros(No_Points,No_Points);

for i=1:1:No_Points
    for j=1:1:No_Points
        for k=1:Nav
        clear net
hiddenLayerSize1 =Multi * i;
hiddenLayerSize2 =Multi * j;
net = newff(minmax(inputs),[hiddenLayerSize1 hiddenLayerSize2 1],{'logsig'  'logsig'  'purelin'},'trainrp');
net.performFcn = 'mse';  % Mean squared error

net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};

net.divideFcn = 'divideind';  
net.divideParam.trainInd = trainInd;
net.divideParam.valInd   = valInd;
net.divideParam.testInd  = testInd;

net.divideMode = 'sample'; 

net.trainParam.goal=0;
net.trainParam.epochs=100;
net.trainParam.max_fail=50;
net.trainParam.showWindow=0;


[net,tr] = train(net,inputs,targets);
%net.performFcn='msereg'; net.performParam.ratio=0.5; 
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};

[net,tr] = train(net,inputs,targets);

outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);


EEE(i,j)=EEE(i,j)+ performance/Nav;
EEErp(i,j)=EEE(i,j);
'1-RP'
((i-1)*No_Points+j)/No_Points/No_Points*100
    end
        
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EEE=zeros(No_Points,No_Points);
%20 trials of hidden layer
for i=1:1:No_Points
    for j=1:1:No_Points
        for k=1:Nav
        clear net
hiddenLayerSize1 =Multi* i;
hiddenLayerSize2 =Multi *j;
net = newff(minmax(inputs),[hiddenLayerSize1 hiddenLayerSize2 1],{'logsig'  'logsig'  'purelin'},'trainlm');
net.performFcn = 'mse';  % Mean squared error

net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};
net.divideFcn = 'divideind';  
net.divideParam.trainInd = trainInd;
net.divideParam.valInd   = valInd;
net.divideParam.testInd  = testInd;

net.divideMode = 'sample'; 
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100; %40/100;
net.divideParam.testRatio = 15/100;
net.trainParam.goal=0;
net.trainParam.epochs=100;
net.trainParam.max_fail=50;
net.trainParam.showWindow=0;


[net,tr] = train(net,inputs,targets);
%net.performFcn='msereg'; net.performParam.ratio=0.5; 
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};

[net,tr] = train(net,inputs,targets);

outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);


EEE(i,j)=EEE(i,j)+ performance/Nav;
EEElm(i,j)=EEE(i,j);
'2-LM'

((i-1)*No_Points+j)/No_Points/No_Points*100
    end
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EEE=zeros(No_Points,No_Points);
%20 trials of hidden layer
for i=1:1:No_Points
    for j=1:1:No_Points
        for k=1:Nav
        clear net
hiddenLayerSize1 =Multi* i;
hiddenLayerSize2 =Multi *j;
net = newff(minmax(inputs),[hiddenLayerSize1 hiddenLayerSize2 1],{'logsig'  'logsig'  'purelin'},'trainscg');
net.performFcn = 'mse';  % Mean squared error

net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};
net.divideFcn = 'divideind';  
net.divideParam.trainInd = trainInd;
net.divideParam.valInd   = valInd;
net.divideParam.testInd  = testInd;

net.divideMode = 'sample'; 
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100; %40/100;
net.divideParam.testRatio = 15/100;
net.trainParam.goal=0;
net.trainParam.epochs=100;
net.trainParam.max_fail=50;
net.trainParam.showWindow=0;


[net,tr] = train(net,inputs,targets);
%net.performFcn='msereg'; net.performParam.ratio=0.5; 
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};

[net,tr] = train(net,inputs,targets);

outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);


EEE(i,j)=EEE(i,j)+ performance/Nav;
EEEscg(i,j)=EEE(i,j);
'3-SCG'

((i-1)*No_Points+j)/No_Points/No_Points*100
    end
        
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EEE=zeros(No_Points,No_Points);
%20 trials of hidden layer
for i=1:1:No_Points
    for j=1:1:No_Points
        for k=1:Nav
        clear net
hiddenLayerSize1 =Multi* i;
hiddenLayerSize2 =Multi *j;
net = newff(minmax(inputs),[hiddenLayerSize1 hiddenLayerSize2 1],{'logsig'  'logsig'  'purelin'},'trainbr');
net.performFcn = 'mse';  % Mean squared error

net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};
net.divideFcn = 'divideind';  
net.divideParam.trainInd = trainInd;
net.divideParam.valInd   = valInd;
net.divideParam.testInd  = testInd;

net.divideMode = 'sample'; 
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100; %40/100;
net.divideParam.testRatio = 15/100;
net.trainParam.goal=0;
net.trainParam.epochs=100;
net.trainParam.max_fail=50;
net.trainParam.showWindow=0;


[net,tr] = train(net,inputs,targets);
%net.performFcn='msereg'; net.performParam.ratio=0.5; 
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};

[net,tr] = train(net,inputs,targets);

outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);


EEE(i,j)=EEE(i,j)+ performance/Nav;
EEEbr(i,j)=EEE(i,j);
'4-BR'

((i-1)*No_Points+j)/No_Points/No_Points*100
    end
        
    end
end

subplot(2,2,1);
title('BBBB')
%No_Points=10;
x = [1 No_Points];
y = [1 No_Points];
clims = [5 50];             % TTE 5-50  DWFD 0 2500  DWFU 100  2700 swcd 0.0003 0.006  swcu 0.0003 0.01
imagesc(x,y,EEElm,clims)
set(gca,'YDir','normal')
colorbar
title('LM')
xlabel('No. of Hidden Units 2nd Layer','FontSize',10)
ylabel('No. of Hidden Units 1st Layer','FontSize',10)


subplot(2,2,2); 


imagesc(x,y,EEErp,clims)
set(gca,'YDir','normal')
colorbar
title('RP')

xlabel('No. of Hidden Units 2nd Layer','FontSize',10)
ylabel('No. of Hidden Units 1st Layer','FontSize',10)


subplot(2,2,3);


imagesc(x,y,EEEbr,clims)
set(gca,'YDir','normal')
colorbar
title('BR')
xlabel('No. of Hidden Units 2nd Layer','FontSize',10)
ylabel('No. of Hidden Units 1st Layer','FontSize',10)

subplot(2,2,4); 

imagesc(x,y,EEEscg,clims)
set(gca,'YDir','normal')
colorbar
title('SCG')
xlabel('No. of Hidden Units 2nd Layer','FontSize',10)
ylabel('No. of Hidden Units 1st Layer','FontSize',10)