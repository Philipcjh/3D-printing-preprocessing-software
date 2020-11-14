function half_edges=triangle_generate(m_edges)
for i=1:size(m_edges,2)/3
    v1x=m_edges(1,3*i-2);
    v1y=m_edges(2,3*i-2);
    v1z=m_edges(3,3*i-2);
    v2x=m_edges(1,3*i-1);
    v2y=m_edges(2,3*i-1);
    v2z=m_edges(3,3*i-1);
    v3x=m_edges(1,3*i);
    v3y=m_edges(2,3*i);
    v3z=m_edges(3,3*i);
    nx=(v1y-v3y)*(v2z-v3z)-(v1z-v3z)*(v2y-v3y);
    ny=(v1z-v3z)*(v2x-v3x)-(v2z-v3z)*(v1x-v3x);
    nz=(v1x-v3x)*(v2y-v3y)-(v2x-v3x)*(v1y-v3y);
    half_edges(i,1:12)=[v1x v1y v1z v2x v2y v2z v3x v3y v3z nx ny nz];
end
half_edges = [half_edges(:,1:12),min(half_edges(:,[2 5 8]),[],2), max(half_edges(:,[2 5 8]),[],2)];
end