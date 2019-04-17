clear all;
data = randi(100,100,2);
%data = [ 1 1; 2 2; 3 3; 4 3; 5 2; 6 1; 3 4; 4 4; 5 6; 6 7;  10 8; 9 8; 8 7;   11 11; 12 12; 13 13; 14 13; 15 12; 16 11;];


% k = 2;
% data = [];
% rng(4);
% 
% for i = 1:k
%     randint = randi([1,1000],1);
%     theta = linspace(0., 2*pi);
%     x = sin(theta)*randint;
%     y = cos(theta)*randint;
%     
%     
%     data = [data;[x' y']];
% end

numClusters = 2;
[assignedClusters,clusterLocations] = kmeans(data,numClusters);

figure;
subplot(1,2,1)
title(['K-means']);
scatter(clusterLocations(:,1), clusterLocations(:,2), 250, 'kx');
hold on;
scatter(data(:,1), data(:,2),[],assignedClusters);



[assignedClusters,clusterLocations] = spectralKmeans(data,2,2);

%
subplot(1,2,2)
title(['spectral']);
scatter(clusterLocations(:,1), clusterLocations(:,2), 250, 'kx');
hold on;
scatter(data(:,1), data(:,2),[],assignedClusters);



