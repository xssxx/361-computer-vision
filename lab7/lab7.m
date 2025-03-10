clear; clc; close all;

% Directories and parameters
trainDir = 'trainset'; testDir = 'testset';
numTrain = 25; numTest = 15; numFeatures = 5;

% Initialize feature matrices
X = zeros(numTrain, numFeatures); XTest = zeros(numTest, numFeatures);

% Process training images
for i = 1:numTrain
    img = imread(fullfile(trainDir, [num2str(i), '.jpg']));
    BW = preprocessImage(img);
    X(i,:) = getShapeFeatures(BW);
end

% Process test images
for i = 1:numTest
    img = imread(fullfile(testDir, [num2str(i), '.jpg']));
    BW = preprocessImage(img);
    XTest(i,:) = getShapeFeatures(BW);
end

% Normalize and train model
X = normalize(X); XTest = normalize(XTest);
load('trainLabel.mat'); load('testLabel.mat');
Mdl = fitcecoc(X, trainLabel);

% Predict and evaluate
predictedLabels = predict(Mdl, XTest);
resultsTable = table(testLabel(:), predictedLabels(:), 'VariableNames', {'TrueLabels', 'PredictedLabels'});
disp(resultsTable);

accuracy = mean(strcmp(testLabel(:), predictedLabels(:))) * 100;
fprintf('Classification Accuracy: %.2f%%\n', accuracy);

% Helper functions
function BW = preprocessImage(img)
    imgGray = rgb2gray(img);
    BW = imbinarize(imgGray, graythresh(imgGray));
    BW = imfill(~BW, 'holes');  % Invert and fill holes
end

function f = getShapeFeatures(BW)
    props = regionprops(BW, 'Area', 'Perimeter', 'Extent', 'MajorAxisLength', 'MinorAxisLength');
    if ~isempty(props)
        [~, idx] = max([props.Area]);
        f = [props(idx).Area, props(idx).Perimeter, props(idx).Extent, props(idx).MajorAxisLength, props(idx).MinorAxisLength];
    else
        f = zeros(1, 5);  % No features if no region
    end
end
