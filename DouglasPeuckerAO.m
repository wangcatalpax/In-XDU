 % Points: 路径数组 N×3 % <-- 修改点：指定路径数组为三维
 % epsilon: 残差
 % 本函数基于原作者天才小傲傲修改
function result = DouglasPeuckerAO(Points, epsilon)
   
    
    p1 = Points(1,:);
    p2 = Points(end,:);
    
    % 判断数组首尾点是否相同，相同则尾点向前取一个，首尾点不能相同
    if isequal(p1, p2)
        p2 = Points(end-1,:);
    end
    
    distanceList = zeros(length(Points),1);
    for i = 2:length(Points)-1
        pointTemp = Points(i,:);
        distanceTemp = pointLineDistance(p1, p2, pointTemp);
        distanceList(i) = distanceTemp;
    end
    
    [MAX, index] = max(distanceList);

    if MAX < epsilon
        result = [p1;p2];
    else
        recResult1 = DouglasPeuckerAO(Points(1:index,:), epsilon);
        recResult2 = DouglasPeuckerAO(Points(index:end,:), epsilon);
        result = [recResult1(1:length(recResult1)-1,:); 
                  recResult2(1:length(recResult2),:)];
    end

end

function result = pointLineDistance(Q1, Q2, P)
    % 采用的3维空间向量叉积的方法求点到直线的最短距离
    result = norm(cross(Q2-Q1, P-Q1)) / norm(Q2-Q1); % <-- 修改点：添加了第三维度
end
