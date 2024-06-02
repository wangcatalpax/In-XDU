function displayrobot(q,Five_dof)
%DISPLAYROBOT 此处显示有关此函数的摘要
%   此处显示详细说明
w=[-1 1 -1 1 0 2]; %w是绘图空间范围[xmin xmax ymin ymax zmin zmax]

Five_dof.plot3d(q,'notiles','workspace',w,'path',...
'D:\Classrobot\STLfile','nowrist','fps',60)
end

