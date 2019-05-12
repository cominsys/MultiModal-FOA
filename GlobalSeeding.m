function New_Trees=GlobalSeeding(candidate, Forest, Eval)

% This function gets the candidate population, the whole Forest and the evaluation function and
% performs global seeding stage on a percentage of candidate population
% Input:
%
%   candidate:  The candidate population from population limiting stage
%   Forest:     The whole Forest
%   Eval:       Evaluation function handler
%
% Output:
%    New_Trees: The new trees as the result of global seeding stage

 index=[];
 New_Trees=[];
 for i=1:Forest.P.GSC
     index=[index, randi([1,Forest.P.Dimension])];
 end 
%% choose a percentage of candidate population
RevoSize=floor(((size(candidate,1))*Forest.P.Transfer_rate)/100);
SelectedTrees=candidate(1:RevoSize, :);
for w=1:size(SelectedTrees,1)    
      tempTree=SelectedTrees(w,:);
      for j=index
          tempTree(1,j)=random('unif',Forest.P.XMinMax(j,1),Forest.P.XMinMax(j,2),1,1);
      end
      tempTree(1,Forest.P.Dimension+1)=Eval(tempTree(1,1:Forest.P.Dimension));
      tempTree(1,Forest.P.Dimension+2)=0;
      New_Trees=[New_Trees; tempTree(1,:)];
end

end