function output = edge_trace(binary_image, x, y)
% edge_trace function - Trace object in binary image
%   output: the output parameter is a Q-by-2 matrix, 
%   where Q is the number of boundary pixels.
[row, col] = size(binary_image);
if row < x || x < 1 || y > col || y < 1
    error("Invalid initial point");
elseif binary_image(x, y) ~= 1
    error("Start point must be a white point");
end

max_length = row * col;

dirs = [
    0, -1;
    -1, -1;
    -1, 0;
    -1, 1;
    0, 1;
    1, 1;
    1, 0;
    1, -1
]; % clock-wise

dirmap = [5, 6, 7, 8, 1, 2, 3, 4];
current_dir = 8;

% init output set
output = [];
output(1, :) = [x, y];
length = 1;

current_x = x;
current_y = y;

while true
    next_dir = nextdir(current_dir);
    finished = false;
    while next_dir ~= current_dir
        delta = dirs(next_dir, :);
        if current_x + delta(1) == x && current_y + delta(2) == y
            % find the initial point again
            % the task has been finished
            finished = true;
            break
        elseif binary_image(current_x + delta(1), current_y + delta(2)) == 1
            current_x = current_x + delta(1);
            current_y = current_y + delta(2);
            break
        else
            next_dir = nextdir(next_dir);
        end
    end
    if finished
        break
    elseif next_dir == current_dir
        % this is not closed
        disp("The object is not closed");
        break
    end
    
    % move to a new point
    current_dir = dirmap(next_dir);
    length = length + 1;
    output(length, :) = [current_x, current_y];
    
    if length >= max_length
        break
    end
    
end

    function next_dir = nextdir(current_dir)
        % calc next direction
        if current_dir == 8
            next_dir = 1;
        else
            next_dir = current_dir + 1;
        end
    end
end
