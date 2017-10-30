function [a] = least_square_m(x,y,m)

A = zeros(m);
for i = -m+1:1:m-1
    A = A + diag(ones(m-abs(i),1)*sum(x.^(i+m-1)),i);
end
A = flipud(A);
b = zeros(m,1);
for i = 1:m
    b(i) = sum(x.^(i-1).*y);
end

a = A\b;
a = a(end:-1:1);
end