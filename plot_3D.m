function h = plot_3D(vertex,face)

% plot_mesh - plot a 3D mesh.
%
%   plot_mesh(vertex,face, options);
%
%   'options' is a structure that may contains:
%       - 'normal' : a (nvertx x 3) array specifying the normals at each vertex.
%       - 'edge_color' : a float specifying the color of the edges.
%       - 'face_color' : a float specifying the color of the faces.
%       - 'face_vertex_color' : a color per vertex or face.
%       - 'vertex'
%


if nargin<2
    error('Not enough arguments.');
end

vertex = vertex';
face = face';

options.face_vertex_color = zeros(size(vertex,1),1);
face_vertex_color = options.face_vertex_color;


if isempty(face_vertex_color)
    h = patch('vertices',vertex,'faces',face,'facecolor',[face_color face_color face_color],'edgecolor',[edge_color edge_color edge_color]);
else
    if size(face_vertex_color,1)==size(vertex,1)
        shading_type = 'interp';
    else
        shading_type = 'flat';
    end
     h = patch('vertices',vertex,'faces',face,'FaceVertexCData',face_vertex_color, 'FaceColor',shading_type);
end
colormap gray(256);%灰度图
lighting phong;%使表面光滑
camlight infinite; 
camproj('perspective');
axis square; 
axis off;

cameratoolbar;
axis tight;
axis equal;
shading interp;
camlight;
% 
