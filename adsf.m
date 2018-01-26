Nu=3;
Set = {[2,3,4,5],[2,3,5,6],[2,5,7,8]};
for n1= 1:Nu-1,
for n2= n1+1:Nu,
    int=0;
    for hk=1:4,
        if (Set{n1}(hk) == Set{n2}(hk))
            int=int+1;
        end
    end
    disp(int);
end
end
res=zeros(1,3);
disp(res);
res(10,:) = [1 3 4];
disp(res);
disp(strcat('abc',num2str(1)));