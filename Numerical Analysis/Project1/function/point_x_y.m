function [x,y] = point_x_y(date_in,weight_in,height_in,isw)

Time = clock;

T_today = [12*(Time(1)-2010)+(Time(2)-1), Time(3)];

Temp = str2double(get(date_in,'String'));
if isnan(Temp)
    x = -1;
elseif Temp<20100101
    x = -2;
else
    year = (ceil(Temp/10000)-1);
    month = ceil(mod(Temp,10000)/100)-1;
    day = mod(Temp,100);
    if month > 12 || month <0 || day>eomday(year,month)
        x = -2;
    else
        T_birth = [12*(year-2010)+month-1,mod(Temp,100)];
        temp = T_today(2) - T_birth(2);
        x = (T_today(1)-T_birth(1)+temp/30);
        if x < 0 || x > 81
            x = -2;
        end
       
    end
end
        if isw
            Temp = str2double(get(weight_in,'String'));
        else
            Temp = str2double(get(height_in,'String'));
        end
        y = (-1)*isnan(Temp) + Temp*(1-isnan(Temp));
        if y <= 0
            y = -1;
        end
end