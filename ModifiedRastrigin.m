function [ y ] = ModifiedRastrigin( x )
sum1 = 0;
sum1 = sum( (10+(9*cos(2*pi.*[3,4].*x))));
y = 100-sum1;
end

