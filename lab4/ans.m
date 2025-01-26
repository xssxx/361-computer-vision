A = imread('dark_rays.jpg'); 
figure();

subplot(1,2,1); imshow(A); title('Original Image');

B = imgaussfilt(A,3);
C = imsharpen(B, 'Radius', 2, 'Amount', 50);
subplot(1,2,2); imshow(C); 
title('Enhanced and Sharpened');