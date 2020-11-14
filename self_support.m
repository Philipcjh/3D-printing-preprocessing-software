function self_support=self_support(self_uprow,self_downrow)
[rownumber,rowelement]=size(self_uprow);
for i=1:rownumber
    row=self_uprow(i,:);
    downrow=self_downrow(i,:);
    point1 = row(1:3); point2 = row(4:6); point3 = row(7:9);
    point4 = [downrow(1),downrow(2),downrow(3)]; point5 = [downrow(4),downrow(5),downrow(6)]; point6 = [downrow(7),downrow(8),downrow(9)];
    v = [point1;point2;point3;point4;point5;point6];
    f = [1 2 3 1; 1 2 5 4; 2 3 6 5; 3 1 4 6; 4 5 6 4];
    self_support = patch('Faces',f,'Vertices',v,'FaceColor','r');
end
end