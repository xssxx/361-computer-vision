I_ref = imread('reference_sm.jpg');
I_ref_gray = rgb2gray(I_ref);
points_ref = detectSURFFeatures(I_ref_gray);
[features_ref, validPoints_ref] = extractFeatures(I_ref_gray, points_ref);
์
imageFiles = dir("starbucks35_dataset\*.JPG");

for i = 1:length(imageFiles)
    
    inputImagePath = fullfile(imageFiles(i).folder, imageFiles(i).name);
    I = imread(inputImagePath);
    I_gray = rgb2gray(I);
    points = detectSURFFeatures(I_gray);
    [features, validPoints] = extractFeatures(I_gray, points);
    indexPairs = matchFeatures( ...
        features_ref, ...
        features, ...
        'Method', ...
        'NearestNeighborRatio', ...
        'MatchThreshold', 4, ...
        'MaxRatio', 0.6);

    matchedPoints1 = validPoints_ref(indexPairs(:, 1));
    matchedPoints2 = validPoints(indexPairs(:, 2));

    figure;
    showMatchedFeatures(I_ref, I, matchedPoints1, matchedPoints2, 'montage');ี
    title(['Matched Features: ', imageFiles(i).name]);
end
