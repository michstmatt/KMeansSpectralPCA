clear;
usps = load('USPS.mat');

images = usps.A;
labels = usps.L;

pcValues = [10, 50, 100, 200];
recvError = zeros(size(pcValues,2),2);

% compute PCA
[pcs, score, mean] = pca(images);

% iterate over different principal component sizes
for idx = 1:size(pcValues,2)
    numPC = pcValues(idx);
    selectedPCs = pcs(:, 1:numPC);
    
    % pca image construction
    pcaImage = score(:,1:numPC)*selectedPCs';
    
    % image reconstruction
    for idx2 = 1:size(images,1)
        pcaImage(idx2, :) = pcaImage(idx2, :) + mean;
    end
    
    diff = images - pcaImage;
    error = zeros(size(images,1),1);
    
    for idx2 = 1:size(images,1)
        error(idx2) = norm(diff(idx2,:), 'fro')^2;
    end
    
    for imgIdx = 1:2
        rImage = reshape(pcaImage(imgIdx,:),16,16);
        f = figure()
        imshow(rImage, 'InitialMagnification','fit');
        title([sprintf('Image reconstruction %d, numPCs %d', imgIdx, numPC)])
        saveas(f,sprintf('./images/img%dpc%d.png',imgIdx,numPC),'png');
        close();
    end
    
    totalError = sum(error);
    recvError(idx,:) = [numPC totalError];

end
f = figure()
scatter(recvError(:,1), recvError(:,2));
title(['Recv error vs num PCs'])
saveas(f,'./images/recv.png','png');
close();


