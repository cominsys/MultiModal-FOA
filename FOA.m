function Forest = FOA(Forest,Eval,ShowResults)

bestTree=Forest.T(randi([1 size(Forest.T,1)]),:);
New_Trees=[];
tic;
% stop condition is the predefined number of iterations
for i=1:Forest.P.MaxIterations
    Forest=LocalSeeding(Forest,Eval);
    [Forest,candidate]=PopulationLimiting(Forest);
    New_Trees=GlobalSeeding(candidate,Forest,Eval);
    Forest.T=[Forest.T;New_Trees];
    [Forest,bestTree]=UpdateBestTree(Forest,bestTree);
    pt = 0.0001;
    if Forest.P.Dimension ==2
        Show(Forest.P.XMinMax,Forest.T(:,:)',Eval,pt,i)
    else
        drawnow;
        plot(0:0.01:1,Eval(0:0.01:1))
        hold on
        plot(Forest.T(:,:)',Eval(Forest.T(:,:)'),'bo');
        axis([Forest.P.XMinMax(1,1)-0.5 Forest.P.XMinMax(1,2)+0.5 Forest.P.XMinMax(2,1)-0.5 Forest.P.XMinMax(2,2)+0.5])
        hold off
    end     

end

Forest.Elapsed=toc;
disp('Forest Optimization Algorithm completed.');
disp(['Elapsed time: ' num2str(Forest.Elapsed) ' seconds.']);
if ShowResults
    
    disp(['The trees of the Forest after the ' num2str(Forest.P.MaxIterations) ' number of iterations are:']);
    disp(['( The first tree indicates the best tree.']);
    disp(['  The ' num2str(Forest.P.Dimension+1) 'th column is the fitness of the related tree']);
    disp(['  The ' num2str(Forest.P.Dimension+2) 'th column is the "Age" of the related tree )']);
    for i=1:1%size(Forest.T(:,:),1)
        format short
        disp(['(' num2str(i) '): ' num2str(Forest.T(i,:))]);
    end
end
hold on
plot(Forest.Temp.ClusterHeads(:,1),Forest.Temp.ClusterHeads(:,2),'ro','MarkerSize', 8, 'LineWidth', 3);
Nc=size(Forest.Temp.ClusterHeads,1)
save('..\FOA', 'Forest')
end %function


