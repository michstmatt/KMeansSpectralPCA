%data = randi(100,100,10);
%data = randi(100,20,2);

data = [ 1 1; 2 2; 3 3; 4 3; 5 2; 6 1; 3 4; 4 4; 5 6; 6 7;  10 8; 9 8; 8 7;   11 11; 12 12; 13 13; 14 13; 15 12; 16 11;];

[assignedClusters,clusterLocations] = spectralKmeans(data,2,2);

%scatter(clusterLocations(:,1), clusterLocations(:,2), 250, 'kx');
hold on
scatter(data(:,1), data(:,2),[],assignedClusters);
