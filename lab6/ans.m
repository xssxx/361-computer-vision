RGB = imread('lymphomalplzhang03_shade.jpg');
imGray = rgb2gray(RGB);

h = fspecial('average', [1000 1000]);
shade = imfilter(imGray, h); 

imCorrected = double(imGray) ./ double(shade);
imCorrected = mat2gray(imCorrected);

level = graythresh(imCorrected); 
BW = imbinarize(imCorrected, level); 
BW = ~BW;

se = strel('disk', 5);      % สร้าง structuring element แบบวงกลม
BW = imclose(BW, se);       % ทำ morphological closing
BW = imopen(BW, se); 
BW = bwareaopen(BW, 50);    % ลบวัตถุที่มีพื้นที่น้อยกว่า 50 pixels

CC = bwconncomp(BW);
stats = regionprops(CC, 'BoundingBox', 'Area');
imout = RGB;

for k = 1:length(stats)
    roi = false(size(BW));
    roi(CC.PixelIdxList{k}) = true;
    imout = drawBoundary(imout, roi);
end

figure;

subplot(2, 2, 1);
imshow(RGB);
title('Original Image');

subplot(2, 2, 2);
imshow(imCorrected);
title('Shade Corrected (Flat-Field)');

subplot(2, 2, 3);
imshow(BW);
title('Thresholded (Black to White)');

subplot(2, 2, 4);
imshow(imout);
title('Segmentation Result Superimposed');