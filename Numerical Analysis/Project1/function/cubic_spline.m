function [d] = cubic_spline(x,y,dy_0,dy_1)

n = length(x);

h = x(2:end) - x(1:end-1);
lambda = h(2:end)./(h(1:end-1)+h(2:end));
mu = 1-lambda;
df = (y(2:end)-y(1:end-1))./h;

C = 3*(lambda.*df(1:end-1) + mu.*df(2:end));
g = 6./(h(1:end-1)+h(2:end)).*(df(2:end)-df(1:end-1));

A = zeros(n-2);
b = [6/h(1)*(df(1)-dy_0); g; 6/h(end)*(dy_1-df(end))];
A = 2*eye(n)+diag([1;lambda],1)+diag([mu;1],-1);
d = A\b;
end