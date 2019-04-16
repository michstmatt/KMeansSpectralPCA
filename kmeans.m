function [assignedClusters,centroidLocations] = kmeans(dataPoints, numClusters)
    
    numDataPoints = size(dataPoints,1);
    
    % instantiate cluster labels for all datapoints
    assignedClusters = zeros(numDataPoints,1);
    
    % select k random data points to use as centroid locations
    index = randsample(1:numDataPoints, numClusters);
    centroidLocations = dataPoints(index,:);
    
    
    

    distances = zeros(numDataPoints, numClusters);
    
    stop = 0;
    
    while stop == 0
    
        % iterate over all the clusters
        for centroidIndex = 1:numClusters
            % find the distance between all data points and the centroid
            % cluster
            diff = dataPoints - centroidLocations(centroidIndex, :);

            cDistances = sqrt(sum(diff.*diff,2));
            distances(:,centroidIndex) = cDistances;
        end

        % find closest centroid
        % find min of each row: https://www.mathworks.com/matlabcentral/answers/300350-min-of-each-row-of-a-matrix-and-their-indexes
        [minDistance,newAssignedClusters] = min(distances,[],2);

        if newAssignedClusters == assignedClusters
            stop = 1;
            break
        end
        
        assignedClusters = newAssignedClusters;

        % iterate over all the clusters
        for centroidIndex = 1:numClusters
            indices = assignedClusters(:) == centroidIndex;
            assignedDataPoints = dataPoints(indices,:);

            newCentroidLocation = mean(assignedDataPoints,1);
            centroidLocations(centroidIndex, :) = newCentroidLocation;

        end
    end
    
    
    % center the clusters around new assignments
    
    



end