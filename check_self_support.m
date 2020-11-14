function [initiate_self_support,downrow] = check_self_support(xp,yp,triangles,tri)
%Take 3 points in a row in turn, judge if all of them cannot reach down;
%To judge a point, projection the point and all triangles on XZ plane,jugde
%if the point is in the triangle easily in this plane.
%The principle of judge is that, if the center point cannot reach down,it can
%self support;if it reaches down,a thorough support from printing
%plane is needed.
%To check if the point is concluded in the triangle,apply area method.
cp=0;
downrow=zeros(1,12);
[row_of_triangles,column_of_triangles] = size(triangles);
for i = tri+1:row_of_triangles
   %面积法判断点是否在三角形内
    rowc = triangles(i,:);
    xc1 = rowc(1);
    yc1 = rowc(3);
    xc2 = rowc(4);
    yc2 = rowc(6);
    xc3 = rowc(7);
    yc3 = rowc(9);
    S1=xc2*yc3+xp*yc2+yp*xc3-yp*xc2-xp*yc3-xc3*yc2;
    S2=xp*yc3+xc1*yp+yc1*xc3-yc1*xp-xc1*yc3-xc3*yp;
    S3=xc2*yp+xc1*yc2+yc1*xp-yc1*xc2-xc1*yp-xp*yc2;
    if S1<=0||S2<=0||S3<=0
        p=0;
    else
        p=1;
    end
    %找出能支撑此面片的最高面片
    if p==1&&cp<(rowc(2)+rowc(5)+rowc(8))/3
        cp=(rowc(2)+rowc(5)+rowc(8))/3;
        downrow=rowc;
    end
end
if cp==0
    initiate_self_support=false;
else
    initiate_self_support=true;
end
end

        
   

