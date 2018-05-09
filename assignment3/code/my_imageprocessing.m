%in this function, you should finish the image processing function to
%extract the longitude and latitude lines using any mothods you consider 
%appropriate.
%please output the image only contains the longitude and latitude lines 
%and the backgroud.
function output = my_imageprocessing(input_image)
    output = xor(input_image, input_image);
    [height, width] = size(input_image);
    for i = 1: height
        for j = 1: width
            if input_image(i, j) ~= 0
                output(i, j) = search(input_image, i, j, 55); % in face, 55, the maxStep is a hyperparameter
            end
        end
    end
    
    function out = search(image, m, n, maxStep)
        directions = [0, 1; -1, 1; -1, 0; -1, -1; 0, -1; 1, -1; 1, 0; 1, 1];
        out = 0;
        for x = 1: 8
            y = mod(x, 8) + 1;
            if dfs(image, m, n, [x, y], maxStep) == maxStep
                out = 1;
                break
            end
        end
            
        function length = dfs(im, a, b, dirs, last)
            length = 0;
            if last ~= 1
                for index= 1: 2
                    next_a = a + directions(dirs(index), 1);
                    next_b = b + directions(dirs(index), 2);
                    if next_a < 1 || next_b < 1 || next_a > height || next_b > width
                        continue
                    elseif im(next_a, next_b) ~= 0
                        length = max(dfs(im, next_a, next_b, dirs, last - 1), length);
                    end
                end
            end
            length = length + 1;
        end      
    end
end
