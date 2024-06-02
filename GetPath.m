function totalPath= GetPath(sphereInfo,PathPoint)
%GETPATH 此处显示有关此函数的摘要
%   此处显示详细说明
%% 定义路径点空间
axisStart = [-1 -1 0];
axisLWH = [2 2 2];
w=[-1 1 -1 1 0 2];
%% 定义障碍物
sphereInfo.exist = 0;
   %创建球形障碍物信息
%% %% 画图
figure(1)
colorMatCube = [1 0 0];
colorMatCylinder = [0 1 0];
colorMatSphere = [0 0 1];
pellucidity = 0.6;    %透明度
hold on;
% scatter3(PathPoint(1,1),PathPoint(1,2),PathPoint(1,3),'MarkerEdgeColor','k','MarkerFaceColor',[1 0 0]);
% scatter3(PathPoint(end,1),PathPoint(end,2),PathPoint(end,3),'MarkerEdgeColor','k','MarkerFaceColor','b');
% text(PathPoint(1,1),PathPoint(1,2),PathPoint(1,3),'起点');
% text(PathPoint(end,1),PathPoint(end,2),PathPoint(end,3),'终点');
view(3)
grid on;
axis equal;
axis([w]);
xlabel('x')
ylabel('y')
zlabel('z')



%% 寻找路径
view(3)
totalPath = [];
for k1 = 1:size(PathPoint,1)-1
    startPoint = PathPoint(k1,:);
    goalPoint = PathPoint(k1+1,:);
    Path = RRT(startPoint,axisStart,axisLWH,goalPoint,sphereInfo);
    
    if ~isempty(Path)
        % for k2 = 1:size(Path,1)-1
        %     line([Path(k2,1) Path(k2+1,1)],[Path(k2,2) Path(k2+1,2)],[Path(k2,3) Path(k2+1,3)],'LineWidth',1,'Color','red');
        % end
        totalPath = [totalPath;Path];
    end
end

    
end

