function [d] = fitting(x,y)


m = 8;
[a] = least_square_m(x(1:18),y(1:18),m);

temp = m-1:-1:0;
temp = temp';
d_a = a.*temp;
dy_0 = polyval(d_a(1:end-1),x(1));


m = 5;
[a] = least_square_m(x(19:36),y(19:36),m);

temp = m-1:-1:0;
temp = temp';
d_a = a.*temp;
dy_1 = polyval(d_a(1:end-1),x(end));

[d] = cubic_spline(x,y,dy_0,dy_1);
