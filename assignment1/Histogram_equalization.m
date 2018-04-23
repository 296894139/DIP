function [output] = Histogram_equalization(input_image)
%first test the image is a RGB or gray image
if numel(size(input_image)) == 3
    %this is a RGB image
    %here is just one method, if you have other ways to do the
    %equalization, you can change the following code
    r=input_image(:,:,1);
    v=input_image(:,:,2);
    b=input_image(:,:,3);
    r1 = hist_equal(r);
    v1 = hist_equal(v);
    b1 = hist_equal(b);
    output = cat(3,r1,v1,b1);    
else
    %this is a gray image
    [output] = hist_equal(input_image);
    
end

    function [output2] = hist_equal(input_channel)
    % ֱ��ͼ���⻯
        
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
        
        % ��0-255֮��ĸ����������ΪͼƬ��ʽ
        output2 = uint8(output2);
    end
end