clear; 
load TTE

training_algorithims={'trainlm'; 'trainscg'; 'trainrp'; 'trainbr'};
No_Points=20; Multi=1;Nav=10;
Hid=zeros(No_Points,1); % hidden neurons axis
Err=zeros(No_Points,4); % error matrix at 4 training algorithms

for k=1:4
for i=1:No_Points
    for j=1:Nav
        clear net
hiddenLayerSize =Multi * i;
net = newff(minmax(inputs),[hiddenLayerSize 1],{'logsig' 'purelin'},cell2mat(training_algorithims(k)));
net.performFcn = 'mse';  % Mean squared error
%net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
%net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};
net.divideFcn = 'divideind';  
net.divideParam.trainInd = trainInd;
net.divideParam.valInd   = valInd;
net.divideParam.testInd  = testInd;


net.divideMode = 'sample'; 

net.trainParam.goal=0;
net.trainParam.epochs=1000;
net.trainParam.max_fail=50;
net.trainParam.showWindow=0;


%net.performFcn='msereg'; net.performParam.ratio=0.5; 
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};

[net,tr] = train(net,inputs,targets);

outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);

Hid(i)=hiddenLayerSize;
Err(i,k)=Err(i,k)+performance/Nav;


    end
    cell2mat(training_algorithims(k))
    (i/No_Points*100)

end
end


plot (Hid(:,1),Err,'LineWidth',1)
legend ('trainlm', 'trainscg', 'trainrp', 'trainbr')
xlabel('No of Hidden Units') % x-axis label
ylabel('Mean Squared Error MSE') % y-axis label
