function [assignedClusters,centroidLocations] = spectralKmeans(dataPoints, numClusters, numPCs)
    

    [numDataPoints, numFeatures] = size(dataPoints);
    
    adjacencyMatrix = zeros(numDataPoints, numDataPoints);
    
    
    for dataIdx1 = 1:numDataPoints
        for dataIdx2 = dataIdx1:numDataPoints
            
            score = 0;
            if dataIdx1 ~= dataIdx2
            
                % compute distance between 2 points
                diff = dataPoints(dataIdx1,:) - dataPoints(dataIdx2,:);
                dist = sqrt(sum(diff.*diff,2));

                score = dist;
            
            end

            adjacencyMatrix(dataIdx1, dataIdx2) = score;
            adjacencyMatrix(dataIdx2, dataIdx1) = score;
        end
    end
    
    
    binaryAdjMatrix = adjacencyMatrix > 0;
    degreeVector = sum(binaryAdjMatrix,1);
    
    degreeMatrix = diag(degreeVector);
    
    laplacianMatrix = degreeMatrix - adjacencyMatrix;
    
    
    % compute eigen vectors and the values diagonal matrix
    [vectors, dValues] = eig(laplacianMatrix);
    
    % convert diag values matrix into a 1d vector
    values = diag(dValues);
    
    % get the largest eigen value and corresponding index
    [sortedVals, indices] = sort(values,'ascend');
    
    % get first numPCs indices
    selectedIndices = indices(1:numPCs);
    
    % get vectors of the corresponding indices
    pcs = vectors(:,selectedIndices);
    eigenVals = sortedVals(1:numPCs);
    
    [assignedClusters,centroidLocations] = kmeans(pcs, numClusters);
    

end