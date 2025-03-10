clear; clc; close all;
trainDir = 'trainset';
testDir = 'testset';
numTrain = 25;
numTest = 15;
numFeatures = 5;
X = zeros(numTrain, numFeatures);
XTest = zeros(numTest, numFeatures);
for i = 1:numTrain
    fileName = fullfile(trainDir, [num2str(i) '.jpg']);
    img = imread(fileName);
    imgGray = rgb2gray(img);
    level = graythresh(imgGray);
    BW = imbinarize(imgGray, level);
    BW = ~BW;
    BW = imfill(BW, 'holes');
    X(i,:) = getShapeFeatures(BW);
end
for i = 1:numTest
    fileName = fullfile(testDir, [num2str(i) '.jpg']);
    img = imread(fileName);
    imgGray = rgb2gray(img);
    level = graythresh(imgGray);
    BW = imbinarize(imgGray, level);
    BW = ~BW;
    BW = imfill(BW, 'holes');
    XTest(i,:) = getShapeFeatures(BW);
end
X = normalize(X);
XTest = normalize(XTest);
load('trainLabel.mat');
load('testLabel.mat');
Mdl = fitcecoc(X, trainLabel);
predictedLabels = predict(Mdl, XTest);
resultsTable = table(testLabel(:), predictedLabels(:), 'VariableNames', {'TrueLabels','PredictedLabels'});
disp(resultsTable);
accuracy = mean(strcmp(testLabel(:), predictedLabels(:)))*100;
fprintf('Classification Accuracy: %.2f%%\n', accuracy);
function f = getShapeFeatures(BW)
    p = regionprops(BW,'Area','Perimeter','Extent','MajorAxisLength','MinorAxisLength');
    if ~isempty(p)
        [~, idx] = max([p.Area]);
        a = p(idx).Area;
        pm = p(idx).Perimeter;
        ex = p(idx).Extent;
        maj = p(idx).MajorAxisLength;
        minr = p(idx).MinorAxisLength;
        f = [a, pm,   ex, maj, minr];
    else
        f = zeros(1,5);
    end
end
