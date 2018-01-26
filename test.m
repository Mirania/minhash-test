%function res = minhash(file, s, k, threshold)
%max s = 20
file='u.data';
%s=15;
k=10;
threshold=0.4;

udata=load(file);
u= udata(1:end,1:2); clear udata;
%linha: user filmes

fprintf('A gerar lista de utilizadores...\n');
users = unique(u(:,1)); 
%lista users
Nu= length(users);
%quant users

fprintf('A encontrar itens para cada user...\n');
Set= cell(Nu,1);
for n = 1:Nu, 
    ind = find(u(:,1) == users(n));
    Set{n} = [Set{n} u(ind,2)];
end
%raw set

%fprintf('A diminuir o tamanho de cada entrada...\n');
%rset = cell(Nu,1);

%for n = 1:Nu,
%    aux = randi(length(Set{n})-s+1);
%    for p = aux:(aux+s-1),
%        rset{n} = [rset{n} Set{n}(p)];
%    end
%end
%diminui a quantidade de itens por user para s


hashed = cell(Nu,1);
h= waitbar(0,'Hashing');
for n= 1:Nu, %para cada user
    waitbar(n/Nu,h);
    for j=1:k %para cada hash function
        val=1e9; %valor maior que um resultado possivel das hash functions
        for x=1:length(Set{n}) %percorrer a lista do user n
            cval=mod(string2hash(strcat(num2str(j),num2str(Set{n}(x))),'sdbm'),1e9);
            if cval<val
                val=cval;
            end
        end
        hashed{n} = [hashed{n} val];
    end
end     
delete (h);

for a=1:length(hashed)
    disp(hashed{a})
end

%passa a lista de itens por user por hash functions,
%escolhe o menor valor para cada hash function
%e gera um novo cell array em que os itens são os menores valores
%dados por cada hash function para a lista
%k é o nº de hash functions usadas

J=zeros(Nu,Nu); % array para guardar distˆancias
res= zeros(1,3);
pos=1;
h= waitbar(0,'A calcular');
for n1= 1:Nu-1,
waitbar(n1/Nu,h);
for n2= n1+1:Nu,
    int=0;
    for hk=1:k,
        if (hashed{n1}(hk) == hashed{n2}(hk))
            int=int+1;
        end
    end
    J(n1,n2) = 1 - (int/k);
   % fprintf('%d %d %d\n',n1,n2,1-(int/k));
    if J(n1,n2)<threshold
        res(pos,:) = [users(n1) users(n2) J(n1,n2)];
        pos= pos+1;
    end
end
end
delete (h);

%disp(res);
%calcula distâncias, e guarda + apresenta se < threshold