load('scramble_code.mat'); 
scrambled_img = imread('scrambled_image.tif');

% Get the dimensions of the scrambled image
[height, width, channels] = size(scrambled_img);

% Initialize an empty array for the unscrambled image
original_img = zeros(height, width, channels, 'like', scrambled_img);

% Reconstruct the image using the scramble code
for i = 1:height
    for j = 1:width
        original_img(r(i), c(j), :) = scrambled_img(i, j, :);
    end
end

imshow(original_img);
imwrite(original_img, 'Lab1/unscrambled_image.png');
