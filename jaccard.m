function J = jaccard(Set)
Nu = length(Set);
J=zeros(Nu,Nu);
h= waitbar(0,'Calculating');

for n1= 1:Nu-1,
waitbar(n1/Nu,h);
for n2= n1+1:Nu,
    int = length(intersect(Set{n1},Set{n2}));
    uni = length(Set{n1})+length(Set{n2})-int;
    J(n1,n2) = 1 - (int/uni);
end
end

delete(h);
end

% J(a,b) = distância de jaccard entre a e b