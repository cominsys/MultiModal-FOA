clc;close all;
Func=1;             
ShowResults=1;      % ShowResults=1; NotShowResults=0;
Iterations=35;      % Maximum number of iterations
area_limit=100;     % The limitation of the forest
Life_time=15;        % The maximum allowed age of a tree
Transfer_rate=10;   % The percentage of candidate population

switch Func
    case 1 % Akley with global optimum f(x)=0
        Eval = @EvaluationAckley;
        ranges = [-5 5;-5 5]; % The range of the variables
        DistThreshold = 0.7;
        dimension=2;
    case 2 % Himmelblau
        Eval = @EvaluationHimmelblau;
        ranges = [-6 6;-6 6]; % The range of the variables
        DistThreshold = 4.8;
        dimension=2;
    case 3 % EqualMaxima
        Eval = @EqualMaxima;
        ranges = [0 1;0 1]; % The range of the variables
        DistThreshold = 0.1414;
        dimension=1;
    case 4 % UnevenDecreasingMaxima
        Eval = @UnevenDecreasingMaxima;
        ranges = [0 1;0 1]; % The range of the variables
        DistThreshold = 0.1414;
        dimension=1;
    case 5 % ShubertBenchmark
        Eval = @ShubertBenchmark;
        ranges = [-10 10;-10 10]; % The range of the variables
        DistThreshold = 0.638;
        dimension=2;
    case 6 % ModifiedRastrigin
        Eval = @ModifiedRastrigin;
        ranges = [0 1;0 1]; % The range of the variables
        DistThreshold = 0.219;
        dimension=2;
    case 7 % SixHumpCamelBack
        Eval = @SixHumpCamelBack;
        ranges = [-1.9 1.9;-1.1 1.1]; % The range of the variables
        DistThreshold = 1.3;
        dimension=2;
end
Forest=InitializeForest(Eval,ranges,dimension,Iterations, area_limit, Life_time, Transfer_rate,DistThreshold);
Forest=FOA(Forest,Eval,ShowResults);

