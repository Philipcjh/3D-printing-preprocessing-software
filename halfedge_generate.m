function h_edges=halfedge_generate(vertex,faces)
% HALF_GENERATE transform the triangular facets information to halfedge data structure
% Input： 
%   vertex: store vertex coordinates of triangles                   
%   vertex's format: 3*n Matrix(n refers to the number of vertexs of triangles) 
%   faces: store three vertex indexes of triangles
%   faces' format: 3*m Matrix(m refers to the number of triangles)
% Output：
%   h_edges：halfedge data structure  
%   h_edges' format: 8*3m Matrix
%   h_edges(1:3,:): Coordinates of starting point of halfedge
%   h_edges(4,:): Index of next halfedge
%   h_edges(5,:): Index of opposite halfedge
%   h_edges(6:8,:): Index of three vertexs on triangles

if nargin>2
    error('Too many variables！');
end
m=size(faces,2);
m_edges=zeros(7,3*m);
for i=1:m
    m_edges(1,3*i-2:3*i)=[faces(1,i) faces(2,i) faces(3,i)];
    m_edges(2,3*i-2:3*i)=[faces(2,i) faces(3,i) faces(1,i)];
    m_edges(3,3*i-2:3*i)=[3*i-1 3*i 3*i-2];
    m_edges(5:7,3*i-2:3*i)=[faces(:,i) faces(:,i) faces(:,i)];
end
map=zeros(2*1e4,2*1e4);
for i=1:3*m
    v1=m_edges(1,i);
    v2=m_edges(2,i);
    if map(v2,v1)~=0
        m_edges(4,i)=map(v2,v1);
        m_edges(4,map(v2,v1))=i;
    else
        map(v1,v2)=i;
    end
end
h_edges=zeros(8,3*m);
for i=1:m
    h_edges(1:3,3*i-2:3*i)=[vertex(:,m_edges(1,3*i-2)) vertex(:,m_edges(1,3*i-1)) vertex(:,m_edges(1,3*i))];
end
h_edges(4,:)=m_edges(3,:);
h_edges(5,:)=m_edges(4,:);
h_edges(6:8,:)=m_edges(5:7,:);
end
