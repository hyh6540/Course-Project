clc; clear; close all;
addpath(genpath(pwd))
%% pre_deal_data
load('data_boy_girl_w_h.mat');

boy_h = boy_h(:,end:-1:1);
boy_w = boy_w(:,end:-1:1);
girl_h = girl_h(:,end:-1:1);
girl_w = girl_w(:,end:-1:1);
[n,m] = size(boy_h);

all_x = year;%(1):0.1:year(end);
n2 = length(all_x);
boy_w2 = zeros(m,n2);
boy_h2 = zeros(m,n2);
girl_w2 = zeros(m,n2);
girl_h2 = zeros(m,n2);
d_bw = zeros(n,m); d_bh = zeros(n,m);
d_gw = zeros(n,m); d_gh = zeros(n,m);
for i = 1:m
    [d] = fitting(year,boy_h(:,i));
    boy_h2(i,:) = spline_y(year,boy_h(:,i),d,all_x);
    d_bh(:,i) = d;
    [d] = fitting(year,boy_w(:,i));
    boy_w2(i,:) = spline_y(year,boy_w(:,i),d,all_x);
    d_bw(:,i) = d;
    [d] = fitting(year,girl_h(:,i));
    girl_h2(i,:) = spline_y(year,girl_h(:,i),d,all_x);
    d_gh(:,i) = d;
    [d] = fitting(year,girl_w(:,i));
    girl_w2(i,:) = spline_y(year,girl_w(:,i),d,all_x);
    d_gw(:,i) = d;
end


%% GUI
isboy = 1;

figure1 = figure('Visible','off','name','main','menubar','none', ...
    'numbertitle','off','Units','pixels','position',[100,400,900,450]);

%% Weight
over_w = 0;
hp_w = uipanel('Title','Weight','FontSize',12,...
                'BackgroundColor',[0.94 0.94 0.94],...
                'Units','normalized','Position',[0.05 0.07 .43 0.7]);


t_weight = uicontrol('Parent',hp_w,'Style', 'text', 'string','kg',...
    'FontSize',10, ...
    'backgroundcolor',[1 1 1]*0.94,'Units','normalized','position',[0.2,0.85,0.1,0.07]);

%Slightly Overweight
String_w = {'No result', 'Overweight','Overweight',  'Slightly Overweight', 'normal weight',...
    'normal weight', 'Slightly Underweight', 'Underweight', 'Underweight'}  ;
w_call_push = [ ...
    '[x,y] = point_x_y(date_in,weight_in,height_in,1);', ...
    'over_w = 0;', ...
    'if x>0 && y>0 ' , ... 
        'over_w = plot_point(x,y,w_axes,h_axes,w_axes2,h_axes2,1,d_bh,d_bw,d_gh,d_gw,isboy,year,boy_h,boy_w,girl_h,girl_w);', ...
    'elseif x>0 && y<0 ' , ...
        'f = errordlg(''Iuput error - invaild weight volume'', ''Error!''); ', ...
    'elseif x<0 && y>0 ' , ...
        'f = errordlg(''Iuput error - invaild birthdate'', ''Error!''); ', ...
    'else ' , ...
        'f = errordlg(''Iuput error - invaild birthdate && weight volume'', ''Error!''); ', ...
    'end ;', ...
    'set(t_w_result,''string'',String_w(over_w+1));'];

t_w_result = uicontrol('Parent',hp_w,'Style', 'text', 'string','No result',...
    'FontSize',12, ...
    'backgroundcolor',[1 1 1]*0.94,'Units','normalized','position',[0.4,0.85,0.6,0.07]);

w_push = uicontrol('Parent',hp_w,'Style', 'pushbutton', 'string','verify',...
    'backgroundcolor',[1 1 1],'Units','normalized','position',[0.1,0.75,0.1,0.08],...
    'callback',w_call_push);

weight_in = uicontrol('Parent',hp_w,'Style', 'edit', 'string','00',...
     'backgroundcolor',[1 1 1],'Units','normalized','position',[0.1,0.85,0.1,0.08]);
 
 
% figure
    w_axes = axes('Parent',hp_w,'Units','normalized','position',[0.12,0.15,0.45,0.5]);
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
    
    w_axes2 = axes('Parent',hp_w,'Units','normalized','position',[0.67,0.15,0.1,0.5]);
    set(w_axes2, 'box', 'on','YGrid','on','XGrid','on',...
        'XLim',[0,1], 'YLim',[0 1]);
    set(w_axes2,'YTick',[0 0.5 1],'YTickLabel',{'0.0','0.5','1.0'},...
        'XTickLabel',{''});
    
%% Height
over_h = 0;
hp_h = uipanel('Title','Height','FontSize',12,...
                'BackgroundColor',[0.94 0.94 0.94],...
                'Units','normalized','Position',[0.52 0.07 .43 0.7]);


t_height = uicontrol('Parent',hp_h,'Style', 'text', 'string','cm',...
    'FontSize',10, ...
    'backgroundcolor',[1 1 1]*0.94,'Units','normalized','position',[0.2,0.85,0.1,0.07]);

String_h = {'No result', 'Overheight','Overheight',  'Slightly Overheight', 'normal height',...
    'normal height', 'Slightly Underheight', 'Underheight', 'Underheight'}  ;
h_call_push = [ ...
    '[x,y] = point_x_y(date_in,weight_in,height_in,0);', ...
    'over_h = 0;', ...
    'if x>0 && y>0 ' , ... 
        'over_h = plot_point(x,y,w_axes,h_axes,w_axes2,h_axes2,0,d_bh,d_bw,d_gh,d_gw,isboy,year,boy_h,boy_w,girl_h,girl_w);', ...
    'elseif x>0 && y<0 ' , ...
        'f = errordlg(''Iuput error - invaild height volume'', ''Error!''); ', ...
    'elseif x<0 && y>0 ' , ...
        'f = errordlg(''Iuput error - invaild birthdate'', ''Error!''); ', ...
    'else ' , ...
        'f = errordlg(''Iuput error - invaild birthdate && height volume'', ''Error!''); ', ...
    'end ;', ...
    'set(t_h_result,''string'',String_h(over_h+1));'];

t_h_result = uicontrol('Parent',hp_h,'Style', 'text', 'string','No result',...
    'FontSize',12, ...
    'backgroundcolor',[1 1 1]*0.94,'Units','normalized','position',[0.4,0.85,0.6,0.07]);



h_push = uicontrol('Parent',hp_h,'Style', 'pushbutton', 'string','verify',...
    'backgroundcolor',[1 1 1],'Units','normalized','position',[0.1,0.75,0.1,0.08],...
    'callback',h_call_push);

height_in = uicontrol('Parent',hp_h,'Style', 'edit', 'string','00',...
     'backgroundcolor',[1 1 1],'Units','normalized','position',[0.1,0.85,0.1,0.08]);
 

% figure

    h_axes = axes('Parent',hp_h,'Units','normalized','position',[0.14,0.15,0.45,0.5]);
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
    
    h_axes2 = axes('Parent',hp_h,'Units','normalized','position',[0.72,0.15,0.08,0.5]);
    set(h_axes2, 'box', 'on','YGrid','on','XGrid','on',...
        'XLim',[0,1], 'YLim',[0 1]);
    set(h_axes2,'YTick',[0 0.5 1],'YTickLabel',{'0.0','0.5','1.0'},...
        'XTickLabel',{''});
%% choose
hp = uipanel('Title','Basic information','FontSize',12,...
                'BackgroundColor',[0.94 0.94 0.94],...
                'Units','normalized','Position',[0.05 0.80 .9 0.15]);

            
boy_girl_call = ['isboy = (1 == get(boy_girl,''value''));', ...
       'plot_line_h_w(all_x,boy_h2,boy_w2,girl_h2,girl_w2,isboy,w_axes,h_axes,w_axes2,h_axes2);'];
   
t_boy_girl = uicontrol('Parent',hp,'Style', 'text', 'string','Sex: ',...
    'FontSize',10 , ...
    'backgroundcolor',[0.94 0.94 0.94],'Units','normalized','position',[0.05/2,0.3,0.1/2,0.4]);

boy_girl = uicontrol('Parent',hp,'Style', 'popupmenu', 'string',{'boy', 'girl'},...
    'FontSize',10 , ...
    'backgroundcolor',[1 1 1],'Units','normalized','position',[0.16/2,0.2,0.2/2,0.55], ...
    'callback',boy_girl_call);

t_date = uicontrol('Parent',hp,'Style', 'text', 'string','Birthdate: ',...
    'backgroundcolor',[0.94 0.94 0.94],'Units','normalized','position',[0.4/2,0.3,0.25/2,0.4]);

date_in = uicontrol('Parent',hp,'Style', 'edit', 'string','20150101',...
    'backgroundcolor',[1 1 1],'Units','normalized','position',[0.65/2,0.2,0.3/2,0.6]);

notice = uicontrol('Parent',hp,'Style', 'text', 'string','Notice: input format of date: 20150812. ',...
    'FontSize',11 , ...
    'backgroundcolor',[1 1 1]*0.94,'Units','normalized','position',[0.525,0.3,0.4,0.4]);



    
set(figure1,'Visible','on')








