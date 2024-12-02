% (long exposure)
img = double(imread('C:\Users\User\Desktop\lab\Lab2\lab2-long exposure\1.jpg'));

for i = 2:50
    filename = imread(['C:\Users\User\Desktop\lab\Lab2\lab2-long exposure\' num2str(i) '.jpg']);
    img = img + double(filename); 
end

img = img / 50;  
img = uint8(img);

% (noise averaging)
img2 = double(imread('C:\Users\User\Desktop\lab\Lab2\lab2-noise averaging\puppy_1.jpg'));

for i = 2:300
    filename = imread(['C:\Users\User\Desktop\lab\Lab2\lab2-noise averaging\puppy_' num2str(i) '.jpg']);
    img2 = img2 + double(filename); 
end

img2 = img2 / 300; 
img2 = uint8(img2);

figure;
subplot(1, 2, 1), imshow(img); 
subplot(1, 2, 2), imshow(img2); 
