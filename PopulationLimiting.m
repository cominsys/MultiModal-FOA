function [Forest,candidate]=PopulationLimiting(Forest)
%% Delete by life time
temp=[];
candidate=[];
for i=1:size(Forest.T,1)
    if  Forest.T(i,Forest.P.Dimension+2)< Forest.P.Life_time
        temp=[temp; Forest.T(i,:)]; % trees with "Age" less than Life_time parameter
    else
        candidate=[candidate; Forest.T(i,:)]; % trees with "Age" bigger than Life_time parameter
    end
end
Forest.T=[];
Forest.T=temp;
%% Clustering
[p,q] = dsort(Forest.T(:,Forest.P.Dimension+1));  % dim+1 shows the fitness
Forest.T = Forest.T(q,:);
C{1} = [1];
Mc(1) = 1;
Nc = 1;
for i=2:size(Forest.T,1)
    Dist = euclidean_dist(Forest.T(i,1:Forest.P.Dimension),Forest.T(Mc, 1:Forest.P.Dimension));
    [MinDist,k] = min(Dist);
    if MinDist <= Forest.P.DistThreshold
        C{k} = [C{k}, i];
    else
        Nc = Nc+1;
        C{Nc} = [i];
        Mc(Nc) = i;
    end
end

%% Select new population
if Forest.P.area_limit < 2*Nc
    disp('FOA Warning: It seems that Area Limit is small. Increasing Area Limit is recommended.');
end

AvgTreePerCluster = Forest.P.area_limit / Nc; %%%%%%% agar tedade dar har cluster kam bashad, moshkel darad
SelectedTrees = zeros(1, Forest.P.area_limit);
PrevIndx = 0;

for i = 1:Nc
    NextIndx = round(i * AvgTreePerCluster);
    NumTrees = NextIndx - PrevIndx;
    if NumTrees < 1
        NumTrees = 1;
    end
    
    ActNumTrees = length(C{i});
    if ActNumTrees > NumTrees
        ActNumTrees = NumTrees;
    end
    
    SelectedTrees(PrevIndx+1 : PrevIndx+ActNumTrees) = C{i}(1:ActNumTrees);
    PrevIndx = PrevIndx + ActNumTrees;
end

if PrevIndx < Forest.P.area_limit
    SelectedTrees = SelectedTrees(1:PrevIndx);
end

%% Set age of cluster-heads to zero
Forest.Temp.ClusterHeads = [];
for  i = 1:Nc
    Forest.T(C{i}(1), Forest.P.Dimension+2) = 0;
    Forest.Temp.ClusterHeads = [Forest.Temp.ClusterHeads; Forest.T(C{i}(1), :)];
end


%% Update Forest


candidate = Forest.T;
candidate(SelectedTrees, :) = [];      % Delete selected trees from "candidates"
Forest.T = Forest.T(SelectedTrees, :); % Keep selected trees in the "Forest"

end %end of function