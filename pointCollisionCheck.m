%监测点是否发生碰撞
function pointFeasible = pointCollisionCheck(checkPoint,radius,circleCenter)
pointFeasible = true;
for s = 1:length(radius)
    if sqrt(sum((checkPoint - circleCenter(s,:)).^2)) <= radius(s)
        pointFeasible = false;
        break;
    end   
end
end
 