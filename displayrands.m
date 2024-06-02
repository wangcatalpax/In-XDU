function displayrands(q,Five_dof)
%DISPLAYRANDS 此处显示有关此函数的摘要
%   此处显示详细说明
w=[-1 1 -1 1 0 2];
figure
view(3)
for k=1:60
    clf
    T=Five_dof.fkine(q(k,:));% 计算当前关节角度对应的末端执行器变换矩阵T
    P=transl(T);%提取末端执行器的位置
    plot_sphere(P,0.038,'r') %绘制小球，球心位置(0.8 0 0.038)，半径为0.038
 
    Five_dof.plot3d(q(k,:),'notiles','workspace',w,'path',...
'D:\Classrobot\STLfile','nowrist','fps',60)
    pause(0)
end
end

