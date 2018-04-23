function output = edge_detection(input_image, kernel_size, sigma, low_threshold, high_threshold)
% canny edge detection
% input:
%       input_image: raw_image
% output:
%       output: binary image after edge detection

% kernel_size must be an odd
if mod(kernel_size, 2) == 0
    error("Kernel size must be an odd");
end
% gauss kernel
kernel = fspecial('gaussian', kernel_size, sigma);
[row, col, dim] = size(input_image);
% convert rgb image to gray image
if dim > 1
    gray_image = rgb2gray(input_image);
else
    gray_image = input_image;
end
gray_image = double(gray_image);
% add padding
padding_image = padarray(gray_image, [(kernel_size - 1) / 2, (kernel_size - 1) / 2], 'replicate');

% filter out noise
smoothed_image = zeros(row, col);
for i = 1:row
    for j = 1:col
        frame = padding_image(i:i+kernel_size-1, j:j+kernel_size-1);
        conv_frame = frame .* kernel;
        smoothed_image(i, j) = sum(conv_frame(:));
    end
end

% use sobel calculate gradient
sobel_dx = [-1 0 1; -2 0 2; -1 0 1];
sobel_dy = [-1 -2 -1; 0 0 0; 1 2 1];
padding_image = padarray(gray_image, [1, 1], 'replicate');

% allocate memory to store gradient and its direction
grad = zeros(row, col);
grad_direction = zeros(row, col);

for i = 1: row
    for j = 1:col
        frame = padding_image(i:i+2, j:j+2);
        dx = sum(sum(sobel_dx .* frame));
        dy = sum(sum(sobel_dy .* frame));
        grad(i, j) = sqrt(dx^2 + dy^2);
        grad_direction(i, j) = dy / dx;
    end   
end

dual_img = zeros(row, col);
for i = 2: row-1
    for j = 2: col-1
        dir = tand(grad_direction(i, j)) + 90;
        if dir >= 0 && dir < 45
            t = abs(grad_direction(i, j));
            grad1 = (1 - t) * grad(i, j + 1) + t * grad(i - 1, j + 1);
            grad2 = (1 - t) * grad(i, j - 1) + t * grad(i + 1, j - 1);
        elseif dir >= 45 && dir < 90
            t = abs(1 / grad_direction(i, j));
            grad1 = (1 - t) * grad(i - 1, j) + t * grad(i - 1, j + 1);
            grad2 = (1 - t) * grad(i + 1, j) + t * grad(i + 1, j - 1);
        elseif dir >= 90 && dir < 135
            t = abs(1 / grad_direction(i, j));
            grad1 = (1 - t) * grad(i - 1, j) + t * grad(i - 1, j - 1);
            grad2 = (1 - t) * grad(i + 1, j) + t * grad(i + 1, j + 1);
        elseif dir >= 135 && dir < 180
            t = abs(grad_direction(i, j));
            grad1 = (1 - t) * grad(i, j - 1) + t * grad(i - 1, j - 1);
            grad2 = (1 - t) * grad(i, j + 1) + t * grad(i + 1, j + 1);
        else
            grad1 = high_threshold;
            grad2 = high_threshold;
        end
        if grad(i, j) >= grad1 && grad(i, j) >= grad2
            if grad(i, j) >= high_threshold
                dual_img(i, j) = 1;  % 1 means the gradient above high_threshold
            elseif grad(i, j) >= low_threshold % 2 means the gradient above low_threshold but 
                dual_img(i, j) = 2; % below high_threshold
            end
        end
    end
end

% use dual threshold build the final output
output = zeros(row, col);
for i = 2: row - 1
    for j = 2: col - 1
       if dual_img(i, j) ~= 2
           output(i, j) = dual_img(i, j);
       else
           neighbour = dual_img(i - 1: i + 1, j - 1: j + 1);
           if any(any(neighbour == 1))
               output(i, j) = 1;
           else
               output(i, j) = 0;
           end
       end
    end
end

end





