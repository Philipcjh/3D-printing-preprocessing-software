function [Crossing_Point_of_All_Slices,y_slices,model_height] = slice_stl_create_path_ycut(m_edges)
%% 模型Y轴向高度
min_y = min(m_edges(2,:))-1e-5;
max_y = max(m_edges(2,:))+1e-5;
model_height = max_y - min_y;
%% 等厚度分层
slice_num=200;
slice_height=(max_y-min_y)/slice_num;
y_slices = min_y: slice_height :max_y;
% 初始化元胞数组 
Crossing_Point_of_All_Slices = {};
%% 寻找相交的半边
slices = y_slices; 
y_halfedge = zeros(size(y_slices,2),4000);
y_halfedge_size = zeros(size(y_slices,2),1);
for i = 1:size(m_edges,2)/3 
    node_lowest = min(m_edges(2,3*i-2:3*i));
    high= size(slices,2); 
    low = 1;
    not_match = true;
    while not_match
        mid = low + floor((high - low)/2);
        if mid == 1 && slices(mid) >= node_lowest  
            check = 2;                      
        elseif mid == size(slices,2) && slices(mid) <= node_lowest    
            check = 2;                       
        elseif slices(mid)>node_lowest && slices(mid-1)<node_lowest 
            check = 0;                      
        elseif slices(mid)>node_lowest     
            check = -1;
        elseif slices(mid) < node_lowest  
            check = 1;
        end

      if check == -1       
          high = mid - 1;   
      elseif check == 1    
          low = mid + 1;  
      elseif check == 0  
          node_lowest = mid;     
          not_match = false;
      elseif high > low || check == 2
          not_match = false;
      end
    end
    y_low_index = mid; 
    node_highest = max(m_edges(2,3*i-2:3*i)); 
    high= size(slices,2); 
    low = 1;              
    not_match = true; 
    while not_match
        mid = low + floor((high - low)/2);
        if mid == 1 && slices(1) <= node_highest   
            check = 2;                              
        elseif mid == size(slices,2) && slices(mid) <=node_highest  
            check = 2;
        elseif slices(mid)>node_highest && slices(mid-1)<node_highest  
            check = 0;                                                 
        elseif slices(mid)>node_highest     
            check = -1;                                             
        elseif slices(mid) < node_highest  
            check = 1;                     
        end

      if check == -1   
          high = mid - 1; 
      elseif check == 1    
          low = mid + 1;    
      elseif check == 0     
          node_highest = mid;   
          not_match = false;
      elseif high > low || check == 2   
          not_match = false;           
      end

    end
    y_high_index = mid;                
    if y_high_index > y_low_index       
        for j = y_low_index:y_high_index-1      
            y_halfedge_size(j) = y_halfedge_size(j) + 1;      
            y_halfedge(j,y_halfedge_size(j)) = i;
        end
    end
end

for  k = 1:size(y_slices,2) 
    halfedge_checklist = y_halfedge(k,1:y_halfedge_size(k));
    if isempty(halfedge_checklist)
        continue;
    end
    for i=1:length(halfedge_checklist)
        half_checklist(1,3*i-2:3*i)=3*halfedge_checklist(1,i)-2:3*halfedge_checklist(1,i);
    end
    [lines,linesize] = half_intersection_ycut(m_edges(1:3,half_checklist), y_slices(k));
   
     if linesize ~= 0
           
            start_nodes = [lines(1:linesize,1) lines(1:linesize,3)];   
            end_nodes = [lines(1:linesize,4) lines(1:linesize,6)];     
            nodes = [start_nodes; end_nodes];       
            % connectivity = [];
            tol_uniquetol = 1e-8;                 
            tol = 1e-8;
            nodes = uniquetol(nodes,tol_uniquetol,'ByRows',true);
            nodes = sortrows(nodes,[1 2]);
            [~, n1] = ismembertol(start_nodes, nodes, tol, 'ByRows',true);
            [~, n2] = ismembertol(end_nodes, nodes,tol,  'ByRows',true);
            conn1 = [n1 n2];
            conn2 = [n2 n1];
            check = ismember(conn2,conn1,'rows');
            conn1(check == 1,:)=[];
            G = graph(conn1(:,1),conn1(:,2));
            bins = conncomp(G);
            Crossing_Point_of_Slice =[];
          for i = 1: max(bins)
            startNode = find(bins==i, 1, 'first');
            path = dfsearch(G, startNode);
            path = [path; path(1)];
            Crossing_Point_of_Slice1 = [nodes(path,1) nodes(path,2)];
            Crossing_Point_of_Slice = [Crossing_Point_of_Slice;Crossing_Point_of_Slice1];     
          end
            Crossing_Point_of_All_Slices(k) = {Crossing_Point_of_Slice}; 
     end
end
end
%%
function [pts_out,size_pts_out] = half_intersection_ycut(half_checklist,y_slices)
n=size(half_checklist,2)/3;
% half_checklist = half_checklist';
p1 = half_checklist(1:3,1:3:3*n-2);
p2 = half_checklist(1:3,2:3:3*n-1);
p3 = half_checklist(1:3,3:3:3*n);

c = ones(1,size(p1,2))*y_slices;
P = [zeros(1,size(p1,2));ones(1, size(p1,2));zeros(1,size(p1,2))];


t1 = (c-sum(P.*p1))./sum(P.*(p1-p2));
t2 = (c-sum(P.*p2))./sum(P.*(p2-p3));
t3 = (c-sum(P.*p3))./sum(P.*(p3-p1));
intersect1 = p1+(p1-p2).*t1;
intersect2 = p2+(p2-p3).*t2;
intersect3 = p3+(p3-p1).*t3;

i1 = intersect1(2,:)<max(p1(2,:),p2(2,:))&intersect1(2,:)>min(p1(2,:),p2(2,:));
i2 = intersect2(2,:)<max(p2(2,:),p3(2,:))&intersect2(2,:)>min(p2(2,:),p3(2,:));
i3 = intersect3(2,:)<max(p3(2,:),p1(2,:))&intersect3(2,:)>min(p3(2,:),p1(2,:));


imain = i1+i2+i3 == 2;

pts_out = [[intersect1(:,i1&i2&imain);intersect2(:,i1&i2&imain)],[intersect2(:,i2&i3&imain);intersect3(:,i2&i3&imain)], [intersect3(:,i3&i1&imain);intersect1(:,i3&i1&imain)]];

pts_out = pts_out'; 
size_pts_out = size(pts_out,1);

end






