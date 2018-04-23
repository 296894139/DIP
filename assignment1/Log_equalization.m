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
    % ͨ�������任�����о��⻯
       
        input_channel = double(input_channel);
        
        % �������
        output2 = log(input_channel + 1);
        
        maxValue = max(max(output2));
        minValue = min(min(output2));
        
        output2 = 255 * (output2 - minValue) / (maxValue - minValue);
       
        % ��0-255֮��ĸ����������ΪͼƬ��ʽ
        output2 = uint8(output2);
       
    end
end

