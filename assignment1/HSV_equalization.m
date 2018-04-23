function [output] = HSV_equalization(input_image)
%first test the image is a RGB or gray image
if numel(size(input_image)) == 3
    %this is a RGB image
    %here is just one method, if you have other ways to do the
    %equalization, you can change the following code
    % ��RGBͼ��ת����HSV�ռ�
    output = rgb2hsv(input_image);
    V = output(:, :, 3);
    output(:, :, 3) = hsv_equal(V, 3);
    output = hsv2rgb(output);
else
    %this is a gray image
    [output] =  hsv_equal(input_image, 1);
    
end

    function [output2] = hsv_equal(input_channel, channels)
    % ֱ��ͼ���⻯
    
        if (channels == 3)
            input_channel = im2uint8(input_channel);
        end
        
        % ���ͼƬ��һЩ��������
        [m, n] = size(input_channel);
        normer = m * n;
        
        % ��ת������
        p = zeros(1, 256); % Ĭ��Ϊ256���Ҷȼ�
        for i = 1:m
            for j = 1:n
                p(input_channel(i, j) + 1) = 1 + p(input_channel(i, j) + 1);
            end
        end
        p = 255 * p / normer;
        p = cumsum(p);
        
        % �������
        output2 = zeros(m, n);
        for i = 1:m
            for j = 1:n
                output2(i, j) = p(input_channel(i, j) + 1);
            end
        end
        
        if (channels == 1)
            output2 = uint8(output2);
        elseif (channels == 3)
             output2 = output2 / max(max(output2));
        end
    end
end
