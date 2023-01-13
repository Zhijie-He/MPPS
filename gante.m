function gante(a,VArray)
% test instance
% a=[ 1    1   0   5;
%     2    2   5   11;
%     3    3   11  16;
%     4    4   16   24;
%     5    5   16   23; %5    8   8   10;
%     6    6   16  20;
%     7    7   24  30;
%     8    8   24  29;
%     9    9  30  39;
%     10    10   36  42;
%     11    11   39  44;
%     12    12  44  48;
%     13    13   42 47;
%     14    14   51  57;
%     15    15   30  36;
%     16    16   44  51;
%     ];
% VArray(1)=8;
% VArray(2)=8;


K = size(VArray,2);
Vsum = size(a,1);
figure(1);
w = 0.5;       % the width of rectangle
set(gcf,'color','w');
for ii = 1:Vsum
    x = a(ii,[3 3 4 4]);
    y = a(ii,1)+[-w/2 w/2 w/2 -w/2];
    if K == 2
        if ii <= VArray(1)
            patch('xdata',x,'ydata',y,'facecolor','red','edgecolor','red','LineWidth',2,'FaceAlpha',.2);
        else
            patch('xdata',x,'ydata',y,'facecolor','blue','edgecolor','blue','LineWidth',2,'FaceAlpha',.2);
        end
    else
        p = patch('xdata',x,'ydata',y,'facecolor','red','edgecolor','red','LineWidth',2,'FaceAlpha',.2);
    end
    txt=sprintf('A(%d)=%d-%d',a(ii,2),a(ii,3),a(ii,4));
    text(a(ii,3)+0.5,a(ii,1),txt,'fontsize',7);
end

tmax = max(a(:,4));

if Vsum > VArray(1)
    x=[tmax-7 tmax-7 tmax-3 tmax-3];
    y=1+[-w/2 w/2 w/2 -w/2];
    patch('xdata',x,'ydata',y,'facecolor','blue','edgecolor','blue','LineWidth',2,'FaceAlpha',.2);
    x=[tmax-7 tmax-7 tmax-3 tmax-3];
    y=2+[-w/2 w/2 w/2 -w/2];
    patch('xdata',x,'ydata',y,'facecolor','red','edgecolor','red','LineWidth',2,'FaceAlpha',.2);
    text(tmax-2.5,1,'Project 2','fontsize',10);
    text(tmax-2.5,2,'Project 1','fontsize',10);
else
    x=[tmax-7 tmax-7 tmax-3 tmax-3];
    y=1+[-w/2 w/2 w/2 -w/2];
    p=patch('xdata',x,'ydata',y,'facecolor','red','edgecolor','red','LineWidth',2,'FaceAlpha',.2);
    text(tmax-2.5,1,'Project 1','fontsize',10);
end

title('A Gantt chart for multi-objective scheduling');
xlabel('processing time(day)');
ylabel('Activity');
xmax = max(a(:,2));
ymax = max(a(:,3));
axis([0 ymax+10 0 xmax+1]);
set(gca,'Box','on');
set(gca,'YTick',0:Vsum);
set(gca,'YTickLabel',[{''};num2str((1:Vsum)','A%d');{''}]);