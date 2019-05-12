function Forest=InitializeForest(Eval, ranges, n, Iterations, limit, Life, Transfer,DistThreshold)
% This function gets the evaluation function, the ranges of the variables,
% the dimension and the maximum number of iterations
% performs global seeding stage on a percentage of candidate population
% Input:
%   Eval:        Evaluation function handler
%   ranges:      A 1*2 matrix containing the lower and the upper limit of the
%   variables
%   n: Dimension of the problem domain
%   Iterations:  The predefined maximum number of iterations used for stop
%   condition
%
% Output:
%    Forest:     The initialized Forest of trees
 
%% Forest.P: Parameters
% Forest.T: Trees
%%
 Forest.P.area_limit=limit; % The limitation of the forest
 Forest.P.Life_time=Life; % The maximum allowed age of a tree (15 is the optimal value)
 Forest.P.Transfer_rate=Transfer; % The percentage of candidate population (small value  like 10)
 Forest.P.Dimension=n; % The dimension of the problem domain
 Forest.P.XMinMax = ranges; 
 Forest.P.DistThreshold = DistThreshold;
 Forest.P.MaxIterations=Iterations; % Maximum number of iterations
 Forest.P.dx=(Forest.P.XMinMax(end,end)/5); % dx is a small value used in local seeding. This value is not used in binary problems.
 if n<3
     Forest.P.LSC=1; % Local seeding Ghanges (1/5 of the dimension)
     Forest.P.GSC=1; % Global seeding changes
 else
     Forest.P.LSC=floor((2*Forest.P.Dimension)/10); % 20 percent of the dimension used in local seeding
     Forest.P.GSC=floor((1*Forest.P.Dimension)/10);     
 end
for j=1:Forest.P.Dimension
  Forest.T(:,j)=random('unif',Forest.P.XMinMax(j,1),Forest.P.XMinMax(j,2),Forest.P.area_limit,1);
end
 for q=1:size(Forest.T,1)
     Forest.T(q,Forest.P.Dimension+1)=Eval(Forest.T(q,1:Forest.P.Dimension));
     Forest.T(q,Forest.P.Dimension+2)=0;
 end
 
end
