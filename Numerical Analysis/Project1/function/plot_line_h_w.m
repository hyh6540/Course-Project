function plot_line_h_w(all_x,boy_h2,boy_w2,girl_h2,girl_w2,isboy,w_axes,h_axes,w_axes2,h_axes2)

if isboy
    cla(w_axes); cla(h_axes);    
    line_w = plot(w_axes,all_x,boy_w2);
    set(line_w(1),'DisplayName','+3sd');
    set(line_w(2),'DisplayName','+2sd');
    set(line_w(3),'DisplayName','+1sd');
    set(line_w(4),'DisplayName','+0sd');
    set(line_w(5),'DisplayName','-1sd');
    set(line_w(6),'DisplayName','-2sd');
    set(line_w(7),'DisplayName','-3sd');
    
    legend_w = legend(w_axes,'show');
    set(legend_w,'Position',[0.85 0.32 0.1 0.3],'FontSize',8);
    xlabel(w_axes,'month');
    ylabel(w_axes,'weight/kg')
    
    set(w_axes, 'box', 'on','YGrid','on','XGrid','on',...
        'XLim',[0 81], 'YLim',[0 40]);
    % height
    
    line_h = plot(h_axes,all_x,boy_h2);
    set(line_h(1),'DisplayName','+3sd');
    set(line_h(2),'DisplayName','+2sd');
    set(line_h(3),'DisplayName','+1sd');
    set(line_h(4),'DisplayName','+0sd');
    set(line_h(5),'DisplayName','-1sd');
    set(line_h(6),'DisplayName','-2sd');
    set(line_h(7),'DisplayName','-3sd');
    set(h_axes, 'box', 'on','YGrid','on','XGrid','on',...
        'XLim',[0 81], 'YLim',[40 140]);
    legend_h = legend(h_axes,'show');
    set(legend_h,'Position',[0.85 0.32 0.1 0.3],'FontSize',8);
    xlabel(h_axes,'month');
    ylabel(h_axes,'height/cm')
    
else
    cla(w_axes); cla(h_axes);    
    line_w = plot(w_axes,all_x,girl_w2);
    set(line_w(1),'DisplayName','+3sd');
    set(line_w(2),'DisplayName','+2sd');
    set(line_w(3),'DisplayName','+1sd');
    set(line_w(4),'DisplayName','+0sd');
    set(line_w(5),'DisplayName','-1sd');
    set(line_w(6),'DisplayName','-2sd');
    set(line_w(7),'DisplayName','-3sd');
    
    legend_w = legend(w_axes,'show');
    set(legend_w,'Position',[0.85 0.32 0.1 0.3],'FontSize',8);
    xlabel(w_axes,'month');
    ylabel(w_axes,'weight/kg')
    
    set(w_axes, 'box', 'on','YGrid','on','XGrid','on',...
        'XLim',[0 81], 'YLim',[0 40]);
    % height
    
    line_h = plot(h_axes,all_x,girl_h2);
    set(line_h(1),'DisplayName','+3sd');
    set(line_h(2),'DisplayName','+2sd');
    set(line_h(3),'DisplayName','+1sd');
    set(line_h(4),'DisplayName','+0sd');
    set(line_h(5),'DisplayName','-1sd');
    set(line_h(6),'DisplayName','-2sd');
    set(line_h(7),'DisplayName','-3sd');
    set(h_axes, 'box', 'on','YGrid','on','XGrid','on',...
        'XLim',[0 81], 'YLim',[40 140]);
    legend_h = legend(h_axes,'show');
    set(legend_h,'Position',[0.85 0.32 0.1 0.3],'FontSize',8);
    xlabel(h_axes,'month');
    ylabel(h_axes,'height/cm')
end
cla(w_axes2);cla(h_axes2);
    set(w_axes2, 'box', 'on','YGrid','on','XGrid','on',...
        'XLim',[0,1], 'YLim',[0 1]);
    set(w_axes2,'YTick',[0 0.5 1],'YTickLabel',{'0.0','0.5','1.0'},...
        'XTickLabel',{''});
    
    set(h_axes2, 'box', 'on','YGrid','on','XGrid','on',...
        'XLim',[0,1], 'YLim',[0 1]);
    set(h_axes2,'YTick',[0 0.5 1],'YTickLabel',{'0.0','0.5','1.0'},...
        'XTickLabel',{''});
end
