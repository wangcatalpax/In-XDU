function drawSphereObject(sphereInfo)

if sphereInfo.exist
    colorMatSphere=sphereInfo.colorMatSphere;
    pellucidity=sphereInfo.pellucidity;

    for k1 = 1:size(sphereInfo.centerX,2)
        xCoor = sphereInfo.centerX(k1);
        yCoor = sphereInfo.centerY(k1);
        zCoor = sphereInfo.centerZ(k1);
        radius = sphereInfo.radius(k1);
        
        [x,y,z] = sphere(50);
        mesh(x*radius+xCoor,y*radius+yCoor,z*radius+zCoor,'FaceAlpha',pellucidity);
        hold on
        w=[-1 1 -1 1 0 2];
       axis([w])
        
        
    end 
    
end

end

