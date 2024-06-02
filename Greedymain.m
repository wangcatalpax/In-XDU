%created by MW
%date: 2022/5/25
%func: show how RRT and GreedyOptimize works
clc;
clear;
 
%% 创建并绘制障碍物
circleCenter = [rand(1,3)*(700-300) + 300;
               rand(1,3)*(700-300) + 300;];
radius = [400;200];
%绘制球形障碍物
figure(1);
[x, y, z] = sphere;      %创建一个坐标在原点，半径为1的标准圆，用于绘制自定义的圆
for i = 1: length(radius)
    mesh(radius(i)*x + circleCenter(i,1), radius(i)*y + circleCenter(i,2), radius(i)*z + circleCenter(i,3));
    hold on;
end
axis equal;
 
%% 创建初始位置和目标位置并绘制
start = [0 0 0];
goal = [700 800 1000];
hold on;
scatter3(start(1),start(2),start(3),'filled','g');
scatter3(goal(1),goal(2),goal(3),'filled','b');
 
%% 图片标注
text(start(1),start(2),start(3),'起点');
text(goal(1),goal(2),goal(3),'终点');
view(3);
grid on;
axis equal;
 axis([0 1000 0 1000 0 1000]);
xlabel('x');
ylabel('y');
zlabel('z');
 
%% RRT方法生成避障轨迹
path = GreedyRRT(start,goal,radius,circleCenter);
 
%% 贪心算法优化RRT轨迹
view(3);
grid on;
axis equal;
axis(w);
xlabel('x');
ylabel('y');
zlabel('z');

newPath = GreedyOptimize(path,radius,circleCenter);

% figure(2);
%绘制球形障碍物
[x, y, z] = sphere;      %创建一个坐标在原点，半径为1的标准圆，用于绘制自定义的圆
for i = 1: length(radius)
    mesh(radius(i)*x + circleCenter(i,1), radius(i)*y + circleCenter(i,2), radius(i)*z + circleCenter(i,3));
    hold on;
end
axis equal;

%绘制原RRT树
plot3(path(:,1), path(:,2), path(:,3),'LineWidth',1,'Color','r');
 hold on;
%绘制优化后的RRT树
for k1 =1: length(newPath)
    point = newPath(k1,:);
    scatter3(point(1),point(2),point(3),'filled','k');   
end
plot3(newPath(:,1), newPath(:,2), newPath(:,3),'LineWidth',3,'Color',[0 0 0]);
 
%图片标注
text(start(1),start(2),start(3),'起点');
text(goal(1),goal(2),goal(3),'终点');
view(3);
grid on;
axis equal;
axis([0 1000 0 1000 0 1000]);
xlabel('x');
ylabel('y');
zlabel('z');