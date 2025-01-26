imageFiles = dir('lab5-images\*.jpg');
numImages = numel(imageFiles);

feature_vector = [];

for i = 1:numImages
    img = imread(fullfile(imageFiles(i).folder, imageFiles(i).name));

    hsv_img = rgb2hsv(img);

    s = hsv_img(:, :, 2);

    check = find(s > 0.3);

    Red = img(:, :, 1);
    Green = img(:, :, 2);
    Blue = img(:, :, 3);
    
    Red = double(Red);
    Green = double(Green);
    Blue = double(Blue);
    
    sum_rgb = Red + Green + Blue; 
    realRed = Red ./ sum_rgb;  
    realGreen = Green ./ sum_rgb;  
    realBlue = Blue ./ sum_rgb; 
    
    realRed = realRed(check);
    realGreen = realGreen(check);
    realBlue = realBlue(check);
    
    meanNormR = mean(realRed);
    meanNormG = mean(realGreen);
    meanNormB = mean(realBlue);

    feature_vector(i, 1) = meanNormR;
    feature_vector(i, 2) = meanNormG;
    feature_vector(i, 3) = meanNormB;
end

Z = linkage(feature_vector, 'complete', 'euclidean');
c = cluster(Z, 'maxclust', 4);

disp('Cluster labels for each image:');
disp(c);

figure;
scatter3(feature_vector(:, 1), feature_vector(:, 2), feature_vector(:, 3), 240, c, 'filled');
xlabel('Normalized Red Channel');
ylabel('Normalized Green Channel');
zlabel('Normalized Blue Channel');
title('Banana Ripeness Clustering');