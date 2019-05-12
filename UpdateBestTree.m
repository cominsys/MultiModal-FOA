function [Forest,bestTree]=UpdateBestTree(Forest,bestTree)

TempBest=bestTree;
Index_of_best=1;
for u=1:size(Forest.T,1)
    if Forest.T(u,Forest.P.Dimension+1)>TempBest(1,Forest.P.Dimension+1)
        TempBest=Forest.T(u,:);
        Index_of_best=u;
    end
end
 if  Forest.T(Index_of_best,Forest.P.Dimension+1)>bestTree(1,Forest.P.Dimension+1)
     bestTree=Forest.T(Index_of_best,:);
     bestTree(1,Forest.P.Dimension+2)=0;
     Forest.T(Index_of_best,:)=[];
     Forest.T=[bestTree;Forest.T];
 else
     updated_best=Forest.T(Index_of_best,:);
     updated_best(1,Forest.P.Dimension+2)=0;
     Forest.T(Index_of_best,:)=[];
     Forest.T=[updated_best;Forest.T];
 end

end