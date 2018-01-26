udata=load('u.data'); % Carrega o ficheiro dos dados dos filmes
% Fica apenas com as duas primeiras colunas
u= udata(1:end,1:2); clear udata;
% Lista de utilizadores
users = unique(u(:,1)); % Extrai os IDs dos utilizadores
Nu= length(users); % N´umero de utilizadores
% Constr´oi a lista de filmes para cada utilizador
Set= cell(Nu,1); % Usa c´elulas
for n = 1:Nu, % Para cada utilizador
% Obt´em os filmes de cada um
ind = find(u(:,1) == users(n));
% E guarda num array. Usa c´elulas porque utilizador tem um n´umero
% diferente de filmes. Se fossem iguais podia ser um array
Set{n} = [Set{n} u(ind,2)];
end
disp(length(Set));

J=zeros(Nu,Nu); % array para guardar distˆancias
h= waitbar(0,'Calculating');
tic
for n1= 1:Nu-1,
waitbar(n1/Nu,h);
for n2= n1+1:Nu,
    int = length(intersect(Set{n1},Set{n2}));
    uni = length(Set{n1})+length(Set{n2})-int;
    %fprintf('%d %d %d %d\n',length(Set{n1}),length(Set{n2}),(int),(uni));
    J(n1,n2) = 1 - (int/uni);
end
end
toc

delete (h);
threshold = 0.4; % limiar de decis˜ao
% Array para guardar pares similares (user1, user2, distˆancia)
SimilarUsers= zeros(1,3);
k= 1;
for n1= 1:Nu-1,
for n2= n1+1:Nu,
if J(n1,n2)<threshold
SimilarUsers(k,:) = [users(n1) users(n2) J(n1,n2)];
k= k+1;
end
end
end
disp(SimilarUsers);