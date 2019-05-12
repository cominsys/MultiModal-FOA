function Show(XMinMax,X,Eval,pt,t)

Mode = 0; % Countour = 0; Surface = 1;
[x1, x2] = meshgrid(XMinMax(1,1): 0.1:XMinMax(1,2),XMinMax(2,1): 0.1:XMinMax(2,2));


[sx, sy] = size(x1);
meshX(1,:) = reshape(x1, 1, (sx*sy));

[sx, sy] = size(x2);
meshX(2,:) = reshape(x2, 1, (sx*sy));
meshX = meshX';
for i=1:length(meshX)
    fx(i) = Eval(meshX(i,:));
end
meshX = meshX';
fx = reshape(fx, sx, sy);

if Mode
    surf(x1,x2,fx);
    view(0, 90);
else
    contourf(x1,x2,fx,15);
end
xlabel('x1');
ylabel(t);
zlabel('fx');
hold on;
plot(X(1,:),X(2,:),'w+','MarkerSize', 8, 'LineWidth', 3);
hold off
if pt>0
    pause(pt);
else
    pause;
end

end

