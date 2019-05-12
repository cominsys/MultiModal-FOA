function Eval = Evaluation6hump(x)
x1 = x(:,1);
x2 = x(:,2);
f = (4 - 2.1*x1.^2 + x1.^4/3).*x1.^2 + x1.*x2 + (-4 + 4*x2.^2).*x2.^2;
Eval = f;
end