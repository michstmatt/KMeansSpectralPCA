function [pcs, score, meanData] = pca(data)

    % get the mean row
    meanData = mean(data,1);
    
    % normalize the data
    normalized = data - meanData;
    
    % compute SVD
    [lSingVecs,singVecs,rSingVecs] = svd(normalized);
    
    % V columns are principal components
    pcs = rSingVecs;
    
    % compute PCA score
    score = normalized * pcs;

end