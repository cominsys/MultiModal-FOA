function [ y ] = UnevenDecreasingMaxima( x )
y = exp(-2.*log10(2).*(((x-0.08)/0.854)).^2) .* sin((5*pi).*(x.^(3/4)-0.05)).^6;
end

