function fx = spline_y(x,y,d,all_x)

h = x(2:end)-x(1:end-1);

n = length(x);

n2 = length(all_x);
fx = zeros(1,n2);
for j = 1:n2
    x0 = all_x(j);
    for i = 1:n
        if x0 >= x(i) && x0 <= x(i+1)
            fx(j) = d(i)/6/h(i)*(x(i+1)-x0)^3 + d(i+1)/6/h(i)*(x0-x(i))^3 ...
                +(y(i)-d(i)/6*h(i)^2)*(x(i+1)-x0)/h(i) ...
                +(y(i+1)-d(i+1)/6*h(i)^2)*(x0-x(i))/h(i);
            break;
        end
    end
end
end