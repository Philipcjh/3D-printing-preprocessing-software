function support = support_generate(triangles,theta,n)

cos_theta = abs(cos(theta));
[row_of_triangles,column_of_triangles] = size(triangles);
%�Ż������񻮷�
%��ȡ��Ƭ���ĵ�Ϊ���񻮷���׼��
x=(triangles(:,1)+triangles(:,4)+triangles(:,7))/3;
y=(triangles(:,3)+triangles(:,6)+triangles(:,9))/3;
xL=max(x)-min(x);
yL=max(y)-min(y);
t1=[];t2=[];t3=[];t4=[];t5=[];t6=[];t7=[];t8=[];t9=[];t10=[];t11=[];t12=[];t13=[];t14=[];t15=[];t16=[];
self_uprow=[];
self_downrow=[];
uprow=[];
%���ֲ��洢16������
for i = 1:row_of_triangles
    xi=4*(x(i)-min(x));
    xmesh=fix(xi/xL)+1;
    yi=4*(y(i)-min(y));
    ymesh=fix(yi/yL)+1;
if xmesh>4
xmesh=4;
end
if ymesh>4
ymesh=4;
end
if xmesh==1&&ymesh==1
t1=[t1;triangles(i,:)];
elseif xmesh==1&&ymesh==2
t2=[t2;triangles(i,:)];
elseif xmesh==1&&ymesh==3
t3=[t3;triangles(i,:)];
elseif xmesh==1&&ymesh==4
t4=[t4;triangles(i,:)];
elseif xmesh==2&&ymesh==1
t5=[t5;triangles(i,:)];
elseif xmesh==2&&ymesh==2
t6=[t6;triangles(i,:)];
elseif xmesh==2&&ymesh==3
t7=[t7;triangles(i,:)];
elseif xmesh==2&&ymesh==4
t8=[t8;triangles(i,:)];
elseif xmesh==3&&ymesh==1
t9=[t9;triangles(i,:)];
elseif xmesh==3&&ymesh==2
t10=[t10;triangles(i,:)];
elseif xmesh==3&&ymesh==3
t11=[t11;triangles(i,:)];
elseif xmesh==3&&ymesh==4
t12=[t12;triangles(i,:)];
elseif xmesh==4&&ymesh==1
t13=[t13;triangles(i,:)];
elseif xmesh==4&&ymesh==2
t14=[t14;triangles(i,:)];
elseif xmesh==4&&ymesh==3
t15=[t15;triangles(i,:)];
elseif xmesh==4&&ymesh==4
t16=[t16;triangles(i,:)];
end
end
%���񻮷����
%��ʼ������Ƭ
for i = 1:row_of_triangles
    row = triangles(i,:);
    n = row(10:12);
    cos_n = n(2)/norm(n);
    %�Ƕȼ���
    if abs(cos_n) >= cos_theta
    %��֧�ż���
    %��ȡ��������Ƭ����
    hri=(row(2)+row(5)+row(8))/3;
    xi=4*(x(i)-min(x));
    xmesh=fix(xi/xL)+1;
    yi=4*(y(i)-min(y));
    ymesh=fix(yi/yL)+1;
    %�ж��������񲢵�ȡ
    if xmesh>4
    xmesh=4;
    end
    if ymesh>4
    ymesh=4;
    end
    if xmesh==1&&ymesh==1
    tin=t1;
    elseif xmesh==1&&ymesh==2
    tin=t2;
    elseif xmesh==1&&ymesh==3
    tin=t3;
    elseif xmesh==1&&ymesh==4
    tin=t4;
    elseif xmesh==2&&ymesh==1
    tin=t5;
    elseif xmesh==2&&ymesh==2
    tin=t6;
    elseif xmesh==2&&ymesh==3
    tin=t7;
    elseif xmesh==2&&ymesh==4
    tin=t8;
    elseif xmesh==3&&ymesh==1
    tin=t9;
    elseif xmesh==3&&ymesh==2
    tin=t10;
    elseif xmesh==3&&ymesh==3
    tin=t11;
    elseif xmesh==3&&ymesh==4
    tin=t12;
    elseif xmesh==4&&ymesh==1
    tin=t13;
    elseif xmesh==4&&ymesh==2
    tin=t14;
    elseif xmesh==4&&ymesh==3
    tin=t15;
    elseif xmesh==4&&ymesh==4
    tin=t16;
    end
    %�õ���������
    %�����ڰ��߶�����
    hh=(tin(:,2)+tin(:,5)+tin(:,8))/3;
    [hh,index]=sort(hh,'descend');
    tin=tin(index,:);
    %�õ��߶����Σ�ȥ�����ڴ˵����Ƭ
    trin=find(hh==hri);
    tri=max(trin);
    %ʹ�ú�������
    xp=x(i);
    yp=y(i);
        [initiate_self_support,downrow] = check_self_support(xp,yp,tin,tri);
        if initiate_self_support == true
            %�洢��֧����������Ϣ
            self_uprow=[self_uprow;row];
            self_downrow=[self_downrow;downrow];
        else
            %�洢����֧����Ƭ��Ϣ
            uprow=[uprow;row];
        end
    end
end
        %����֧��
        selfsupport = self_support(self_uprow,self_downrow);
        support = support_print(uprow);
end

function support_print = support_print(uprow)
[rownumber,rowelement]=size(uprow);
for i=1:rownumber
    row=uprow(i,:);
    point1 = row(1:3); point2 = row(4:6); point3 = row(7:9);
    point4 = [point1(1),0,point1(3)]; point5 = [point2(1),0,point2(3)]; point6 = [point3(1),0,point3(3)];
    v = [point1;point2;point3;point4;point5;point6];
    f = [1 2 3 1;1 2 5 4; 2 3 6 5; 3 1 4 6; 4 5 6 4];
    support_print = patch('Faces',f,'Vertices',v,'FaceColor','b');
end

end
