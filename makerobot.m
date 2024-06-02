function  Five_dof=makerobot
%MAKEROBOT 
L(1)=Link('revolute','d',0.216,'a',0,'alpha',pi/2);
L(2)=Link('revolute','d',0,'a',0.5,'alpha',0,'offset',pi/2);
L(3)=Link('revolute','d',0,'a',sqrt(0.145^2+0.42746^2),'alpha',0,'offset',-atan(427.46/145));
L(4)=Link('revolute','d',0,'a',0,'alpha',pi/2,'offset',atan(427.46/145));
L(5)=Link('revolute','d',0.258,'a',0,'alpha',0);
%使用SerialLink函数，将五个机械臂放入类Five_dof
Five_dof=SerialLink(L,'name','5-dof');
%transl是生成平移变换矩阵的函数，此处用来设置基座位置
Five_dof.base=transl(0,0,0.28);
end

