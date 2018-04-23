function [output] = Log_equalization(input_image)
%first test the image is a RGB or gray image
if numel(size(input_image)) == 3
    %this is a RGB image
    %here is just one method, if you have other ways to do the
    %equalization, you can change the following code
    r=input_image(:,:,1);
    v=input_image(:,:,2);
    b=input_image(:,:,3);
    r1 = log_equal(r);
    v1 = log_equal(v);
    b1 = log_equal(b);
    output = cat(3,r1,v1,b1);    
else
    %this is a gray image
    [output] = log_equal(input_image);
    
end

    function [output2] = log_equal(input_channel)
    % 通过对数变换来进行均衡化
       
        input_channel = double(input_channel);
        
        % 计算输出
        output2 = log(input_channel + 1);
        
        maxValue = max(max(output2));
        minValue = min(min(output2));
        
        output2 = 255 * (output2 - minValue) / (maxValue - minValue);
       
        % 把0-255之间的浮点数矩阵归为图片格式
        output2 = uint8(output2);
       
    end
end

