function [assignedClusters,centroidLocations] = spectralKmeans(dataPoints, numClusters, numPCs)
    

    [numDataPoints, numFeatures] = size(dataPoints);
    
    adjacencyMatrix = zeros(numDataPoints, numDataPoints);
    
    
    for dataIdx1 = 1:numDataPoints
        for dataIdx2 = dataIdx1:numDataPoints
            % compute distance between 2 points
            diff = dataPoints(dataIdx1,:) - dataPoints(dataIdx2,:);
            dist = sqrt(sum(diff.*diff,2));
            
            % closer is better
            
            if dist == 0;
                score = 1;
            end
            score = inv(dist);
            if score > 0.1
                score = 1;
            else
                score = 0;
            end
            
            adjacencyMatrix(dataIdx1, dataIdx2) = score;
            adjacencyMatrix(dataIdx2, dataIdx1) = score;
        end
    end
    
    degreeVector = sum(adjacencyMatrix,1);
    degreeMatrix = diag(degreeVector);
    
    laplacianMatrix = adjacencyMatrix - degreeMatrix;
    
    
    % compute eigen vectors and the values diagonal matrix
    [vectors, dValues] = eig(laplacianMatrix);
    
    % convert diag values matrix into a 1d vector
    values = diag(dValues);
    
    % get the largest eigen value and corresponding index
    [sortedVals, indices] = sort(values,'descend');
    
    % get first numPCs indices
    selectedIndices = indices(1:numPCs);
    
    % get vectors of the corresponding indices
    pcs = vectors(:,selectedIndices);
    eigenVals = sortedVals(1:numPCs);
    
    [assignedClusters,centroidLocations] = kmeans(pcs, numClusters);

end