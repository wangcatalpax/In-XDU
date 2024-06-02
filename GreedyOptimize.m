%基于原作者 CSDN写写画画 W 修改
function newPath = GreedyOptimize(path,radius,circleCenter)
 
startIndex = 1;
goalIndex = length(path(:,1));
detectTimes = length(path(:,1)) - 1;          %检测次数
newPath = [path(startIndex,:)];               %添加初始位置
 
while detectTimes >0;
    detectTimes = detectTimes-1;
    start = path(startIndex,:);
    goal = path(goalIndex,:);
    
    %碰撞检测
    feasible = collisionDetec(goal,start,radius,circleCenter);
    if ~feasible
        goalIndex = goalIndex - 1;            %若碰撞，index减1，继续向上探索父节点
        continue;                            
    else
        newPath = [newPath; goal];            %若未发生碰撞，表示找到一个最优节点，则从该节点往上的所有父节点均可省略，将该节点添加至路径中
        detectTimes = length(path(:,1)) - goalIndex;        %检测次数更位
        startIndex = goalIndex;               %将当前节点索引更新为新的树的起点
        goalIndex = length(path(:,1));        %将终点索引复位
 
    end
   
end
 
newPath = [newPath; path(end,:)];   %添加目标位置
 newPath(end, :) = [];
end
 