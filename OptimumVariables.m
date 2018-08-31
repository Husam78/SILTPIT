clear all; 
load TTE
Epoch_1=5000;
Valid_fail=2500;
hiddenLayerSize = 7;  % if two layers put each one on a different variable
hiddenLayerSize2 = 3;  % if two layers put each one on a different variable
nettte = newff(minmax(inputs),[hiddenLayerSize hiddenLayerSize2 1],{'logsig' 'logsig' 'purelin'},'trainbr');
nettte.performFcn = 'mse';  % Mean squared error
nettte.divideFcn = 'divideind';  
nettte.divideParam.trainInd = trainInd;
nettte.divideParam.valInd   = valInd;
nettte.divideParam.testInd  = testInd;
nettte.divideMode = 'sample'; 
nettte.trainParam.goal=0;
nettte.trainParam.epochs=Epoch_1;
nettte.trainParam.max_fail=Valid_fail;
%nettte.trainParam.showWindow=0;
netdwfd.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
[nettte,tr] = train(nettte,inputs,targets);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   DWFD
load DWFD
hiddenLayerSize = 3;  % if two layers put each one on a different variable
hiddenLayerSize2 = 3;  % if two layers put each one on a different variable
netdwfd = newff(minmax(inputs),[hiddenLayerSize hiddenLayerSize2 1],{'logsig' 'logsig' 'purelin'},'trainbr');
netdwfd.performFcn = 'mse';  % Mean squared error
netdwfd.divideFcn = 'divideind';  
netdwfd.divideParam.trainInd = trainInd;
netdwfd.divideParam.valInd   = valInd;
netdwfd.divideParam.testInd  = testInd;
netdwfd.divideMode = 'sample'; 
netdwfd.trainParam.goal=0;
netdwfd.trainParam.epochs=Epoch_1;
netdwfd.trainParam.max_fail=Valid_fail;
%nettte.trainParam.showWindow=0;
netdwfd.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
[netdwfd,tr] = train(netdwfd,inputs,targets);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   DWFU
load DWFU
hiddenLayerSize = 5;  % if two layers put each one on a different variable
hiddenLayerSize2 = 2;  % if two layers put each one on a different variable
netdwfu = newff(minmax(inputs),[hiddenLayerSize hiddenLayerSize2 1],{'logsig' 'logsig' 'purelin'},'trainbr');
netdwfu.performFcn = 'mse';  % Mean squared error
netdwfu.divideFcn = 'divideind';  
netdwfu.divideParam.trainInd = trainInd;
netdwfu.divideParam.valInd   = valInd;
netdwfu.divideParam.testInd  = testInd;
netdwfu.divideMode = 'sample'; 
netdwfu.trainParam.goal=0;
netdwfu.trainParam.epochs=Epoch_1;
netdwfu.trainParam.max_fail=Valid_fail;
%nettte.trainParam.showWindow=0;
netdwfu.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
[netdwfu,tr] = train(netdwfu,inputs,targets);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   SWCD
load SWCD
hiddenLayerSize = 5;  % if two layers put each one on a different variable
hiddenLayerSize2 = 2;  % if two layers put each one on a different variable
netswcd = newff(minmax(inputs),[hiddenLayerSize hiddenLayerSize2 1],{'logsig' 'logsig' 'purelin'},'trainbr');
netswcd.performFcn = 'mse';  % Mean squared error
netswcd.divideFcn = 'divideind';  
netswcd.divideParam.trainInd = trainInd;
netswcd.divideParam.valInd   = valInd;
netswcd.divideParam.testInd  = testInd;
netswcd.divideMode = 'sample'; 
netswcd.trainParam.goal=0;
netswcd.trainParam.epochs=Epoch_1;
netswcd.trainParam.max_fail=Valid_fail;
%nettte.trainParam.showWindow=0;
netswcd.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
[netswcd,tr] = train(netswcd,inputs,targets);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   SWCU
load SWCU
hiddenLayerSize = 5;  % if two layers put each one on a different variable
hiddenLayerSize2 = 2;  % if two layers put each one on a different variable
netswcu = newff(minmax(inputs),[hiddenLayerSize hiddenLayerSize2 1],{'logsig' 'logsig' 'purelin'},'trainbr');
netswcu.performFcn = 'mse';  % Mean squared error
netswcu.divideFcn = 'divideind';  
netswcu.divideParam.trainInd = trainInd;
netswcu.divideParam.valInd   = valInd;
netswcu.divideParam.testInd  = testInd;
netswcu.divideMode = 'sample'; 
netswcu.trainParam.goal=0;
netswcu.trainParam.epochs=Epoch_1;
netswcu.trainParam.max_fail=Valid_fail;
%nettte.trainParam.showWindow=0;
netswcu.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
[netswcu,tr] = train(netswcu,inputs,targets);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% EXCEL CASE STUDIES %%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% vp Wmin  Wmax 
%%%%% 3  0.75  1.5
%%%%% 4  1     2
%%%%% 5  1.25  2.5
CASESTUDIES=xlsread('CASESTUDIES.xlsx');
ins=CASESTUDIES(:,2:5)';
results=zeros(29,6);
for jjjj=1:29
    rrrr=ins(:,jjjj);

if rrrr(4,1)==3; W=linspace(0.75,1.5,30);end
if rrrr(4,1)==4; W=linspace(1,2,30);end
if rrrr(4,1)==5; W=linspace(1.25,2.5,30);end
    
for kk=1:size(W,2)
    %sand% clay% Vw/W Slope Vp
    inloop(:,kk)= [rrrr(1,1);  rrrr(2,1);   rrrr(3,1)/W(kk);    0;   rrrr(4,1)];
end


TTE_NN=nettte(inloop);
TTE_NNnorm=mapminmax(TTE_NN,0,100);
%%plot(W,TTE_NN,'LineWidth',1);
%%title('TTE predicted by NN');
%%xlabel('width W (m)') % x-axis label
%%ylabel('Normalized Value (0-100)') % y-axis label
%%figure
DWFD_NN=netdwfd(inloop);
DWFD_NNnorm=mapminmax(DWFD_NN,0,100);
%%plot(W,DWFD_NN,'LineWidth',1);
%%title('DWFD predicted by NN');
%%xlabel('width W (m)') % x-axis label
%%ylabel('Normalized Value (0-100)') % y-axis label
%%figure
DWFU_NN=netdwfu(inloop);
DWFU_NNnorm=mapminmax(DWFU_NN,0,100);
%%plot(W,DWFU_NN,'LineWidth',1);
%%title('DWFU predicted by NN','LineWidth',1);
%%xlabel('width W (m)') % x-axis label
%%ylabel('Normalized Value (0-100)') % y-axis label
%%figure
SWCD_NN=netswcd(inloop);
SWCD_NNnorm=mapminmax(SWCD_NN,0,100);
%%plot(W,SWCD_NN,'LineWidth',1);
%%title('SWCD predicted by NN','LineWidth',1);
%%xlabel('width W (m)') % x-axis label
%%ylabel('Normalized Value (0-100)') % y-axis label
%%figure
SWCU_NN=netswcu(inloop);
SWCU_NNnorm=mapminmax(SWCU_NN,0,100);
%%W,SWCU_NN,'LineWidth',1);
%%title('SWCU predicted by NN');
%%xlabel('width W (m)') % x-axis label
%%ylabel('Normalized Value (0-100)') % y-axis label

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%       ALL TOGETHER            %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
ALL_NN=(TTE_NNnorm+DWFD_NNnorm+DWFU_NNnorm+SWCD_NNnorm+SWCU_NNnorm)/5;
plot(W,ALL_NN,'LineWidth',1);
title('Cost Function predicted by NN');
xlabel('width W (m)') % x-axis label
ylabel('Normalized Cost (0-100)') % y-axis label

[opppp,ind]=max(ALL_NN)
results(jjjj,1)=W(ind);
results(jjjj,2)=TTE_NN(ind);
results(jjjj,3)=DWFD_NN(ind);
results(jjjj,4)=DWFU_NN(ind);
results(jjjj,5)=SWCD_NN(ind);
results(jjjj,6)=SWCU_NN(ind);

end
