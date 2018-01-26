[Set,users] = init('u.data');
J = jaccard(Set);
sim = similar(J, users, 0.4);
disp(sim);