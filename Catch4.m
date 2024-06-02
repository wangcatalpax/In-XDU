%% 
clear
clc
%% 定义路径点空间与绘图空间
axisStart = [-1 -1 0];
axisLWH = [2 2 2];
w=[-1 1 -1 1 0 2];
grid on;
axis equal;
axis([w])
xlabel('x')
ylabel('y')
zlabel('z')
view(3)
%% %% 取球路径
PathPoint = [0.6855     0       1.141;
            0.5    0.6 0.8              %到第一途经点
             -0.5         -0.6     0.8  %夹取点
             0            -0.6    0.8
             0.6855     0       1.141];  %放置点
%% 定义放置平台
pos_platform=[PathPoint(4,1),PathPoint(4,2),PathPoint(4,3)]
vertice = [
    pos_platform(1) - 0.1, pos_platform(2) - 0.1, pos_platform(3) - 0.038;
    pos_platform(1) - 0.1, pos_platform(2) + 0.1, pos_platform(3) - 0.038;
    pos_platform(1) + 0.1, pos_platform(2) + 0.1, pos_platform(3) - 0.038;
    pos_platform(1) + 0.1, pos_platform(2) - 0.1, pos_platform(3) - 0.038;
    pos_platform(1) - 0.1, pos_platform(2) - 0.1, pos_platform(3) - 0.08;
    pos_platform(1) - 0.1, pos_platform(2) + 0.1, pos_platform(3) - 0.08;
    pos_platform(1) + 0.1, pos_platform(2) + 0.1, pos_platform(3) - 0.08;
    pos_platform(1) + 0.1, pos_platform(2) - 0.1, pos_platform(3) - 0.08;
]; %定义了8个顶点
face=[1 2 3 4;
          1 2 6 5;
          1 4 8 5;
          2 3 7 6;
          3 4 8 7]; %按照上述顶点的标号定义面，下面交给patch函数绘图

%% 绘制放置平台
patch('Vertices',vertice,'Faces',face,'FaceColor',[0.82 0.71 0.55]);%绘制多面体作为平台
%% 定义与展示机械臂
q0=[0 0 0 0 0];   %q0是初始关节角度，初始关节角度都为0
q1=[0 0 0 0 0];  
set(gcf,'position', get(0, 'Screensize'))   %设置绘图窗口全屏
Five_dof=makerobot;                     %定义机械臂
displayrobot(q0,Five_dof);              %画机械臂
hold on;   
%% 定义与展示障碍物
sphereInfo.exist = 0;                   %定义障碍物
sphereInfo = createSphereObject(sphereInfo);   
drawSphereObject(sphereInfo);            %展示障碍物
hold on
%% 展示路径点
axis([w])
scatter3(PathPoint(1,1),PathPoint(1,2),PathPoint(1,3),'MarkerEdgeColor','k','MarkerFaceColor',[1 0 0]);
hold on
scatter3(PathPoint(2,1),PathPoint(2,2),PathPoint(2,3),'MarkerEdgeColor','k','MarkerFaceColor','b');
hold on
scatter3(PathPoint(3,1),PathPoint(3,2),PathPoint(3,3),'MarkerEdgeColor','k','MarkerFaceColor','b');
hold on
scatter3(PathPoint(4,1),PathPoint(4,2),PathPoint(4,3),'MarkerEdgeColor','k','MarkerFaceColor','b');
view(3)
text(PathPoint(1,1),PathPoint(1,2),PathPoint(1,3),'起点','FontSize', 12,'FontWeight','bold' );
text(PathPoint(2,1),PathPoint(2,2),PathPoint(2,3),'途经点','FontSize', 12,'FontWeight','bold' );
text(PathPoint(3,1),PathPoint(3,2),PathPoint(3,3),'夹取点','FontSize', 12,'FontWeight','bold' );
text(PathPoint(4,1),PathPoint(4,2),PathPoint(4,3),'放置点','FontSize', 12,'FontWeight','bold' );
MakeShow=1;
%% 获取路径
totalPath1= GetPath(sphereInfo,PathPoint(1:2, :));
totalPath2= GetPath(sphereInfo,PathPoint(2:3, :));
totalPath3= GetPath(sphereInfo,PathPoint(3:4, :));
totalPath4= GetPath(sphereInfo,PathPoint(4:5, :));
MakeShow=1;
%% 输入障碍物信息
radius=sphereInfo.radius;
circleCenter = [sphereInfo.centerX', sphereInfo.centerY', sphereInfo.centerZ'];
%% 贪心算法优化路径
newPath1 = GreedyOptimize(totalPath1,radius,circleCenter);
plot3(totalPath1(:,1), totalPath1(:,2), totalPath1(:,3),'LineWidth',2,'Color','r');
plot3(newPath1(:,1), newPath1(:,2), newPath1(:,3),'LineWidth',2,'Color','g');
Step1=size(newPath1,1)-1

newPath2 = GreedyOptimize(totalPath2,radius,circleCenter);
plot3(totalPath2(:,1), totalPath2(:,2), totalPath2(:,3),'LineWidth',2,'Color','r');
plot3(newPath2(:,1), newPath2(:,2), newPath2(:,3),'LineWidth',2,'Color','g');
Step2=size(newPath2,1)-1

newPath3 = GreedyOptimize(totalPath3,radius,circleCenter);
plot3(totalPath3(:,1), totalPath3(:,2), totalPath3(:,3),'LineWidth',2,'Color','r');
plot3(newPath3(:,1), newPath3(:,2), newPath3(:,3),'LineWidth',2,'Color','g');
Step3=size(newPath3,1)-1

newPath4 = GreedyOptimize(totalPath4,radius,circleCenter);
plot3(totalPath4(:,1), totalPath4(:,2), totalPath4(:,3),'LineWidth',2,'Color','r');
plot3(newPath4(:,1), newPath4(:,2), newPath4(:,3),'LineWidth',2,'Color','g');
Step4=size(newPath4,1)-1

newPath = [newPath1;newPath2(2:end, :);newPath3(2:end, :);newPath4(2:end, :)];
MakeShow=1;
clf

%% 绘图
plot_sphere([-0.5         -0.6     0.8],0.038,'r')
Steps=size(newPath,1)
k=1
for k=1:Steps-1
T=transl(newPath(k+1,:))* trotx(pi)%rpy2tr([0 0 0]); 
q0=q1;
q1=Five_dof.ikunc(T); %ikunc是求解逆运动学的函数，求解逆运动学得到机械臂的关节参数
qt1=jtraj(q0,q1,60);


 if (k>(Step1+Step2))&&(k<=(Step1+Step2+Step3))
 clf
for p=1:60
   
clf
    drawSphereObject(sphereInfo); 
patch('Vertices',vertice,'Faces',face,'FaceColor',[0.82 0.71 0.55]);


    TT=Five_dof.fkine(qt1(p,:));% 计算当前关节角度对应的末端执行器变换矩阵T
    P=transl(TT);%提取末端执行器的位置
    ballHandle=plot_sphere(P,0.038,'r') %绘制小球，球心位置(0.8 0 0.038)，半径为0.038
    Five_dof.plot3d(qt1(p,:),'notiles','workspace',w,'path',...
'D:\Classrobot\STLfile','nowrist','fps',60)
 
end

 else
 if k<=(Step1+Step2)
    plot_sphere([-0.5         -0.6     0.8],0.038,'r')
drawSphereObject(sphereInfo); 
patch('Vertices',vertice,'Faces',face,'FaceColor',[0.82 0.71 0.55]);
displayrobot(qt1,Five_dof);    
 else
     % plot_sphere([-0.5         -0.6     0.8],0.038,'r')
drawSphereObject(sphereInfo); 
patch('Vertices',vertice,'Faces',face,'FaceColor',[0.82 0.71 0.55]);
displayrobot(qt1,Five_dof);    
 end



 end 



end
MakeShow=1;
