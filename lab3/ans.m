I = rgb2gray(imread('chest.jpg'));

low_in = 20/255; 
high_in = 130/255;
low_out = 0;
high_out = 1;

J1 = imadjust(I, [low_in high_in], [low_out high_out]);

J2 = histeq(I);
    
J3 = adapthisteq(I, 'ClipLimit', 0.01);

figure;
subplot(1,4,1), imshow(I), title('Original Grayscale');
subplot(1,4,2), imshow(J1), title('Intensity Adjusted (imadjust)');
subplot(1,4,3), imshow(J2), title('Histogram Equalization (histeq)');
subplot(1,4,4), imshow(J3), title('Adaptive Histogram Eq. (adapthisteq)');
