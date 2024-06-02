%机械臂主文件未调用此函数，本函数主要用于Greedymain文件的演示用
%本函数基于原作者：CSDN 写写画画 W修改
function path = GreedyRRT(start,goal,radius,circleCenter)
%% 定义RRT参数
stepSize = 20;                           %步长
maxIterTimes = 5000;                     %最大迭代步数
iterTime = 0;                            %当前迭代次数
threshold = 20;                          %阈值
searchSize = [1000 1000 1000];           %空间尺寸
RRTree = double([start -1]);             %创建RRT树,共4列。前3列为节点坐标，第4列为当前节点的父节点的索引。初始点的索引为-1
 
%多个点到某一点欧式距离计算方法
calcDis = @(a,b) sqrt((b(:,1)-a(1,1)).^2 + (b(:,2)-a(1,2)).^2 + (b(:,3)-a(1,3)).^2);
 
%% 寻找RRT路径
tic                       % tic-toc函数，用于计时，记录完成整个RRT树的运行时间
pathFound = false;        %标志物，记录是否正确找到避障路径
while iterTime <= maxIterTimes
    iterTime = iterTime +1;
    %step1 - 生成随机点
    %为了提高RRT扩展的导向性，以50%的概率在空间中随机生成生成新的随机点，50%的概率以目标点为新的随机点
    if rand < 0.5   
        sample = rand(1,3) .* searchSize + start;
    else
        sample = goal;
    end
    
    %step2 - 寻找树上最近父节点
    [val,nearIndex] = min(calcDis(sample, RRTree(:,1:3)),[],1);       %计算树上每个节点到随机点的欧氏距离，并返回最短距离的值和index
    closestNode = RRTree(nearIndex,1:3);
    
    %step3 - 沿生长向量方向按照步长生成新的子节点
    growVec = sample - closestNode;
    growVec = growVec/sqrt(sum(growVec.^2));
    newPoint = closestNode + growVec*stepSize;
    
    %step4 - 碰撞检测
    feasible = collisionDetec(newPoint,closestNode,radius,circleCenter);
    if ~feasible
        continue;         %如果发生碰撞，则重新寻找随机点      
    end
    
    %为树添加新节点
    RRTree = [RRTree; 
                   newPoint nearIndex];
    plot3([closestNode(1) newPoint(1)],[closestNode(2) newPoint(2)],[closestNode(3) newPoint(3)],'LineWidth',1,'Color','b');
    pause(0.01);
    
    %检测是否到达goal附近
    if sqrt(sum((newPoint - goal).^2)) <= threshold
        pathFound = true;
        break;           %如果节点已到达goal附近，则结束搜寻
    end
   
end
 
%搜索结束后如果搜索失败，显示错误信息
if ~pathFound
    disp('no path found. maximum attempts reached');
end
 
toc
 
%% 绘制回溯路径
path = goal;
lastNode = nearIndex;           %父节点索引，这里的nearIndex是goal的父节点索引
while lastNode >= 0
    path =[RRTree(lastNode,1:3); path];         %将当前节点的上一个节点添加进回溯路径中
    lastNode = RRTree(lastNode, 4);             %更新父节点索引
end
plot3(path(:,1), path(:,2), path(:,3),'LineWidth',1,'Color','r');
 
end