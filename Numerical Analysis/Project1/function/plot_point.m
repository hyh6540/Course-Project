function over = plot_point(x0,y0,w_axes,h_axes,w_axes2,h_axes2,isweight,d_bh,d_bw,d_gh,d_gw,isboy,year,boy_h,boy_w,girl_h,girl_w)

marker_size = 4;
x_min = max(0,x0-1);
x_max = min(x0+1,81);
x = x_min:0.0001:x_max;
y = zeros(7,length(x));
y_0 =  zeros(7,1);
flag = 1;
if isweight
    cla(w_axes);
    for i = 1:7
        y(i,:) = spline_y(year,boy_w(:,i)*isboy+(1-isboy)*girl_w(:,i),...
            d_bw(:,i)*isboy+(1-isboy)*d_gw(:,i),x);
    end
    line_w = plot(w_axes,x,y,x0,y0);
    set(line_w(end),'Marker','^','Markersize',marker_size);
    set(w_axes, 'box', 'on','YGrid','on','XGrid','on',...
        'XLim',[x_min,x_max], 'YLim',[min(min(min(y)),y0)*0.9 max(max(max(y)),y0)*1.1]);
    set(line_w(1),'DisplayName','+3sd');
    set(line_w(2),'DisplayName','+2sd');
    set(line_w(3),'DisplayName','+1sd');
    set(line_w(4),'DisplayName','+0sd');
    set(line_w(5),'DisplayName','-1sd');
    set(line_w(6),'DisplayName','-2sd');
    set(line_w(7),'DisplayName','-3sd');
    set(line_w(8),'DisplayName','now');
    legend_w = legend(w_axes,'show');
    set(legend_w,'Position',[0.85 0.32 0.1 0.3],'FontSize',8);
    xlabel(w_axes,'month');
    ylabel(w_axes,'weight/kg');
    % w_axes2
    cla(w_axes2);
    for i = 1:7
        y_0(i) = spline_y(year,boy_w(:,i)*isboy+(1-isboy)*girl_w(:,i),...
            d_bw(:,i)*isboy+(1-isboy)*d_gw(:,i),x0);
        if flag && y_0(i) < y0
            over = i;
            flag = 0;
        end
    end
    if flag
        over = 8;
    end
    line_w2 = plot(w_axes2,0.5,y_0);
    set(line_w2(1),'Marker','*','Markersize',marker_size);
    set(line_w2(2),'Marker','*','Markersize',marker_size);
    set(line_w2(3),'Marker','*','Markersize',marker_size);
    set(line_w2(4),'Marker','*','Markersize',marker_size);
    set(line_w2(5),'Marker','*','Markersize',marker_size);
    set(line_w2(6),'Marker','*','Markersize',marker_size);
    set(line_w2(7),'Marker','*','Markersize',marker_size);
    set(w_axes2, 'box', 'on','YGrid','on','XGrid','on',...
        'XLim',[0,1], 'YLim',[min(min(min(y_0)))*0.9 max(max(max(y_0)))*1.1]);
    set(w_axes2,'YTick',y_0(end:-1:1),'YTickLabel',num2str(y_0(end:-1:1),'%.1f'),...
        'XTickLabel',{''});
else
    cla(h_axes);
    for i = 1:7
        y(i,:) = spline_y(year,boy_h(:,i)*isboy+(1-isboy)*girl_h(:,i),...
            d_bh(:,i)*isboy+(1-isboy)*d_gh(:,i),x);
    end
    line_h = plot(h_axes,x,y,x0,y0);
    set(line_h(end),'Marker','^','Markersize',marker_size);
    set(h_axes, 'box', 'on','YGrid','on','XGrid','on',...
        'XLim',[x_min,x_max], 'YLim',[min(min(min(y)),y0)*0.9 max(max(max(y)),y0)*1.1]);
    set(line_h(1),'DisplayName','+3sd');
    set(line_h(2),'DisplayName','+2sd');
    set(line_h(3),'DisplayName','+1sd');
    set(line_h(4),'DisplayName','+0sd');
    set(line_h(5),'DisplayName','-1sd');
    set(line_h(6),'DisplayName','-2sd');
    set(line_h(7),'DisplayName','-3sd');
    set(line_h(8),'DisplayName','now');
    legend_h = legend(h_axes,'show');
    set(legend_h,'Position',[0.85 0.32 0.1 0.3],'FontSize',8);
    xlabel(h_axes,'month');
    ylabel(h_axes,'height/cm');
    % h_axes2
    cla(h_axes2);
    for i = 1:7
     y_0(i) = spline_y(year,boy_h(:,i)*isboy+(1-isboy)*girl_h(:,i),...
            d_bh(:,i)*isboy+(1-isboy)*d_gh(:,i),x0);
        if flag && y_0(i) < y0
            over = i;
            flag = 0;
        end
    end
    if flag
        over = 8;
    end
    line_h2 = plot(h_axes2,0.5,y_0);
    set(line_h2(1),'Marker','*','Markersize',marker_size);
    set(line_h2(2),'Marker','*','Markersize',marker_size);
    set(line_h2(3),'Marker','*','Markersize',marker_size);
    set(line_h2(4),'Marker','*','Markersize',marker_size);
    set(line_h2(5),'Marker','*','Markersize',marker_size);
    set(line_h2(6),'Marker','*','Markersize',marker_size);
    set(line_h2(7),'Marker','*','Markersize',marker_size);
    set(h_axes2, 'box', 'on','YGrid','on','XGrid','on',...
        'XLim',[0,1], 'YLim',[min(min(min(y_0)))*0.9 max(max(max(y_0)))*1.1]);
    set(h_axes2,'YTick',y_0(end:-1:1),'YTickLabel',num2str(y_0(end:-1:1),'%.1f'),...
        'XTickLabel',{''});
end
end