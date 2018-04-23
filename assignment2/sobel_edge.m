function output = sobel_edge(input_image, threshold)
% sobel edge detection
%   input_image: image
%   threshold

[row, col, dim] = size(input_image);
if dim > 1
    gray_image = rgb2gray(input_image);
else
    gray_image = input_image;
end
gray_image = double(gray_image);

kernel_x = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
kernel_y = [-1, -2, -1; 0, 0, 0; 1, 2, 1];

padding_image = padarray(gray_image, [1, 1], 'replicate');

output = zeros(row, col);
for i=1: row
    for j=1: col
        frame = padding_image(i:i+2, j:j+2);
        dx = kernel_x .* frame;
        dy = kernel_y .* frame;
        output(i, j) = abs(sum(dx(:))) + abs(sum(dy(:)));
    end
end
output(output < threshold) = 0;
output(output >= threshold) = 1;

end