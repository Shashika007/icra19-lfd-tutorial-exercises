function plot_animation_circle(X,DX,X_initial,Center,Radius,Target,Option)

close all

%%
screensize = get( 0, 'Screensize' );
figure1 = figure();
set(figure1,'Position',screensize)
limits=Option.limits;
axes1 = axes('Parent',figure1);
% Create axes
hold(axes1,'on');
ylim(axes1,[limits(3) limits(4)]);
xlim(axes1,[limits(1) limits(2)]);
axis equal
xlabel('X [m]','Interpreter','latex');
ylabel('Y [m]','Interpreter','latex');
box(axes1,'on');
grid(axes1,'on');
set(axes1,'FontSize',20,'TickLabelInterpreter','latex');
ylim(axes1,[limits(3) limits(4)]);
xlim(axes1,[limits(1) limits(2)]);
r = Radius ;
th = linspace(0,2*pi) ;
x = r*cos(th)+Center(1) ;
y = r*sin(th)+Center(2) ;
patch('YData',y,'XData',x,'FaceAlpha',0.6,...
    'LineStyle','none',...
    'FaceColor',[0.666666686534882 0.243137255311012 0.0588235296308994],'DisplayName','Contact surface') ;


plot(Center(1),Center(2),'DisplayName','Center of circle',...
    'MarkerFaceColor',[1 0 0],...
    'MarkerEdgeColor',[1 0 0],...
    'MarkerSize',20,...
    'LineStyle','none',...
    'Marker','o');


plot(Target(1),Target(2),'DisplayName','$x^*$',...
    'MarkerFaceColor',[0.494117647409439 0.184313729405403 0.556862771511078],...
    'MarkerEdgeColor','none',...
    'MarkerSize',20,...
    'LineStyle','none',...
    'Marker','hexagram');

t = linspace(0,2*pi);
rin =Radius;
rout = Radius+Option.rho;
xin = Center(1) + rin*cos(t);
xout =Center(1) + rout*cos(t);
yin = Center(2)+ rin*sin(t);
yout = Center(2) + rout*sin(t);
patch([xout,xin],[yout,yin],'g','linestyle','none','FaceAlpha',0.3,'DisplayName','Transition region',...
    'LineStyle','none',...
    'FaceColor',[0.850980401039124 0.325490206480026 0.0980392172932625]);


i=1;
 plot(smooth(X{i}(1,1:2)),smooth(X{i}(2,1:2)),'LineWidth',2,'Color',[0 0.447058826684952 0.74117648601532],'DisplayName','Executed motion');
 plot(smooth(X{i}(1,1)),smooth(X{i}(2,1)),'DisplayName','Initial Position',...
    'MarkerFaceColor',[0 0.447058826684952 0.74117648601532],...
    'MarkerEdgeColor',[0 0.447058826684952 0.74117648601532],...
    'MarkerSize',5,...
    'Marker','o',...
    'LineStyle','none',...
    'Color',[0 0.447058826684952 0.74117648601532]);
legend1 = legend(axes1,'show');
%  un=smooth(DX{i}(1,1:10:end))./sqrt(smooth(DX{i}(1,1:10:end)).^2+smooth(DX{i}(2,1:10:end)).^2);
%  wn=smooth(DX{i}(2,1:10:end))./sqrt(smooth(DX{i}(1,1:10:end)).^2+smooth(DX{i}(2,1:10:end)).^2);
%  quiver(smooth(X{i}(1,1:10:end)),smooth(X{i}(2,1:10:end)),un,wn,0.25)
set(legend1,'Interpreter','latex');

for i=1:size(X,2) 
     plot(smooth(X{i}(1,1)),smooth(X{i}(2,1)),'DisplayName','Initial Position',...
    'MarkerFaceColor',[0 0.447058826684952 0.74117648601532],...
    'MarkerEdgeColor',[0 0.447058826684952 0.74117648601532],...
    'MarkerSize',5,...
    'Marker','o',...
    'LineStyle','none',...
    'Color',[0 0.447058826684952 0.74117648601532]);
end

SIZE=size(X{1},2);
for i=1:size(X,2)
    counter{i}=1;
end
n=1;
v = VideoWriter('Circle.mp4');
open(v);
pause(5)
while counter{1}<SIZE
    for i=1:size(X,2)
        counter{i}=min(int64(counter{i}+size(X{i},2)/100),size(X{i},2));
    end
    for i=1:size(X,2)
        plot(smooth(X{i}(1,1:counter{i})),smooth(X{i}(2,1:counter{i})),'LineWidth',2,'Color',[0 0.447058826684952 0.74117648601532]);
    end
    % Capture the plot as an image
    frame = getframe(figure1);
    writeVideo(v,frame);
    %       im = frame2im(frame);
    %       [imind,cm] = rgb2ind(im,256);
    %
    %       % Write to the GIF File
    %       if n == 1
    %           imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    %       else
    %           imwrite(imind,cm,filename,'gif','WriteMode','append');
    %       end
    n=n+1;
end
close(v);