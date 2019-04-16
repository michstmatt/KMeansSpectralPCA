data = [0 0; -1 2; -3 6; 1 -2; 3 -6;];

[pc, val, newData] = pca(data,2);

scatter(data(:,1), data(:,2))