img = imread('dark_rays.jpg');

B = imboxfilt(img, 3);   
B = imgaussfilt(B, 2.5);

imshowpair(img, B, 'montage');
title('Original Image (Left) | Unsharpened Image (Right)');
