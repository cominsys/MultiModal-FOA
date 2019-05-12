function [ a ] = SixHumpCamelBack( x )
x1 = x(:,1);
x2 = x(:,2);
y = -4*((4-2.1*x1.^2+x1.^4/3).*x1.^2+x1.*x2+(-4+4*x2.^2).*x2.^2);
a = 100 + y;
end

