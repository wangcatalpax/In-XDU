%新的生长向量是否发生碰撞
function feasible = collisionDetec(newPoint,closestNode,radius,circleCenter)
feasible = true;
checkVec = newPoint - closestNode;    %检测向量
%将检测向量以0.005为步长等比均分为无数个检测点，检测每个检测点是否与球发生碰撞
for i = 0:0.005:sqrt(sum(checkVec.^2))
    checkPoint = closestNode + i.*(checkVec/sqrt(sum(checkVec.^2)));     %生成检测点
    checkPointFeasible = pointCollisionCheck(checkPoint,radius,circleCenter);
    if ~checkPointFeasible
        feasible = false;
        break;
    end 
end
end
 