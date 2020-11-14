function [s,c,h]= plot_slices_3D(Crossing_Point_of_All_Slices, y_slices,Number_of_Slice)
% 静态绘制三维截面轮廓
%判断滑块传递数值是否越界
if Number_of_Slice<2
    Number_of_Slice=2;
end
Crossing_Point_of_each_Slice = Crossing_Point_of_All_Slices{Number_of_Slice};R=[];l=length(Crossing_Point_of_each_Slice(:,1));
for i=1:l-1
    dx=Crossing_Point_of_each_Slice(i,1)-Crossing_Point_of_each_Slice(i+1,1);
    dz=Crossing_Point_of_each_Slice(i,2)-Crossing_Point_of_each_Slice(i+1,2);
    r=sqrt(dx^2+dz^2);
    R=[R r];
end
hsum=y_slices(1,end)-y_slices(1,1);
hsum=1.5/20*hsum;
h=[];
s=0;c=0;
Slice=y_slices(Number_of_Slice);
R=R';
[s,c,h]=cutshape(Crossing_Point_of_each_Slice,h,hsum,R,s,c,Slice);
end

function [s,c,h]=cutshape(A,h,hsum,R,s,c,Slice)
for i=1:length(R)
    if R(i)>hsum
        R_max=R(i);
        cut_num=i;
        break;
    end
    if i==length(R)
        R_max=0;
    end  
end
if R_max>hsum
    hold on;
    h1=plot3(A(1:cut_num,1),ones(cut_num,1)*Slice,A(1:cut_num,2),'k','LineWidth',0.5,'Color',[1 0 0]);
    h=[h h1];
    s1=polyarea(A(1:cut_num,1),A(1:cut_num,2));
    c1=sum(R(1:cut_num-1,1));
    c=c+c1;
    s=s+s1;
    R=R(cut_num+1:end,1);
    A=A(cut_num+1:end,1:2);
    [s,c,h]=cutshape(A,h,hsum,R,s,c,Slice);
else
    hold on;
    h1=plot3(A(:,1),ones(size(A,1),1)*Slice,A(:,2),'k','LineWidth',0.5,'Color',[1 0 0]);
    s1=polyarea(A(:,1),A(:,2));
    s=s+s1;
    c1=sum(R);
    c=c+c1;
    h=[h h1];
end
end