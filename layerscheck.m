clc

clear; 
load TTE
warning off;

hiddenLayerSize = 7;  % if two layers put each one on a different variable
hiddenLayerSize2 = 3;  % if two layers put each one on a different variable
%net = newff(minmax(inputs),[hiddenLayerSize  1],{'logsig'  'purelin'},'trainbr');
net = newff(minmax(inputs),[hiddenLayerSize hiddenLayerSize2 1],{'logsig' 'logsig' 'purelin'},'trainbr');

net.performFcn = 'mse';  % Mean squared error
%net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
%net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};
net.divideFcn = 'divideind';  
net.divideParam.trainInd = trainInd;
net.divideParam.valInd   = valInd;
net.divideParam.testInd  = testInd;

net.divideMode = 'sample'; 
%net.divideParam.trainRatio = 70/100;
%net.divideParam.valRatio = 15/100;
%net.divideParam.testRatio = 15/100;
net.trainParam.goal=0;
net.trainParam.epochs=5000;
net.trainParam.max_fail=1000;
%net.trainParam.showWindow=0;
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};

[net,tr] = train(net,inputs,targets);

outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);



%figure
%plotregression(targets,outputs,'NN Regression')

%%%%%%%% Linear Model PRediction
Linearmdl=fitlm(inputs',targets');
 W=Linearmdl.Coefficients{:,1};
predicted_values=predict(Linearmdl,inputs');
errorsMLR = gsubtract(targets,predicted_values');

figure
plotregression(targets,predicted_values,'MLR Regression',targets,outputs,'NN Regression')

figure 
plot (1:1512,targets,1:1512,outputs, 1:1512,predicted_values,'LineWidth',1)
legend ('Actual SWCU', 'NN Prediction', 'MLR Prediction','Location','Best')
xlabel('Observation Number') % x-axis label
ylabel('SWCU Value (theta)') % y-axis label
box on


figure
ploterrhist(errorsMLR,'MLR Prediction Error',errors,'NN Prediction Error')
box on

'MSE      RMSE  NN-LIN'
mse (targets,outputs)
sqrt(mse (targets,outputs))
aard=0;
for kkk=1:1512
    aard=aard+100/1512*abs((targets(kkk)-outputs(kkk))/targets(kkk));
end
aard

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%      NEW PREPROCESSING       %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
targets2 =log10(((targets-0.275)/(56.22-0.275))*9.9+.1);  %t
net2 = newff(minmax(inputs),[hiddenLayerSize  1],{'logsig'  'purelin'},'trainlm');
net2.performFcn = 'mse';  % Mean squared error
%net2.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
%net2.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};

net2.divideFcn = 'divideind';  
net2.divideParam.trainInd = trainInd;
net2.divideParam.valInd   = valInd;
net2.divideParam.testInd  = testInd;


net2.divideMode = 'sample'; 
%net2.divideParam.trainRatio = 70/100;
%net2.divideParam.valRatio = 15/100;
%net2.divideParam.testRatio = 15/100;
net2.trainParam.goal=0;
net2.trainParam.epochs=5000;
net2.trainParam.max_fail=100;
%net2.trainParam.showWindow=0;
net2.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};

[net2,tr2] = train(net2,inputs,targets2);

outputs2 = net2(inputs);
outputs2=(10.^outputs2-.1)*(56.22-0.275)/9.9+0.275;

errors2 = gsubtract(targets,outputs2);
performance2 = perform(net2,targets,outputs2);

figure 
plot (1:1512,targets,1:1512,outputs, 1:1512,outputs2,'LineWidth',1)
legend ('Actual TTE', 'NN-LIN Prediction', 'NN-LOG Prediction','Location','Best')
xlabel('Observation Number') % x-axis label
ylabel('TTE Value (HR)') % y-axis label
box on


figure
ploterrhist(errors,'NN-LIN Prediction Error',errors2,'NN-LOG Prediction Error')
box on

figure
plotregression(targets,outputs,'NN-LIN Regression',targets,outputs2,'NN-LOG Regression')

clc



'MSE      RMSE      MLR'
mse (targets,predicted_values')
sqrt(mse (targets,predicted_values'))
aard=0;
for kkk=1:1512
    aard=aard+100/1512*abs((targets(kkk)-predicted_values(kkk,1))/targets(kkk));
end
aard


'MSE      RMSE  NN-LOG'
mse (targets,outputs2)
sqrt(mse (targets,outputs2))
aard=0;
for kkk=1:1512
    aard=aard+100/1512*abs((targets(kkk)-outputs2(kkk))/targets(kkk));
end
aard

