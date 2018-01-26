function [Set,users] = init(file)
udata=load(file);
u= udata(1:end,1:2); clear udata;

users = unique(u(:,1)); 
Nu= length(users);

Set= cell(Nu,1);
for n = 1:Nu, 
ind = find(u(:,1) == users(n));
Set{n} = [Set{n} u(ind,2)];
end
end

%Set{user} = lista de filmes avaliados por esse user