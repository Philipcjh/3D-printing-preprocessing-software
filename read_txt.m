function [vertex,face] = read_txt(filename)
% [n,x,y,z]=textread(filename,'%s%n%n%n');i=1;
fid=fopen(filename,'r');
C=textscan(fid,'%s%n%n%n');i=1;
n=C{1};
x=C{2};
y=C{3};
z=C{4};
while i>0
    if n{i}=='v'
        i=i+1;
    else 
        break;
    end
end
vertex=[x(1:i-1,1) y(1:i-1,1) z(1:i-1,1)]';
face=[x(i:end,1) y(i:end,1) z(i:end,1)]';