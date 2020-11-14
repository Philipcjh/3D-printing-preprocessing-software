function vertex = updatev(vertex,A)

vertex = vertex*A;
[m,n] = size(vertex);
a = min(vertex(:,1)); b = min(vertex(:,2)); c = min(vertex(:,3));
if a < 0
    vertex = vertex-a*[ones(m,1),zeros(m,2)];
end
if b < 0
    vertex = vertex-b*[zeros(m,1),ones(m,1),zeros(m,1)];
end
if c < 0
    vertex = vertex-c*[zeros(m,2),ones(m,1)];
end

end