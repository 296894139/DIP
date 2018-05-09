%DIP16 Assignment 3
maindir = '../asset/image';
subdir  = dir( maindir );

for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '..')||...
        ~subdir( i ).isdir )
        continue;
    end

    subdirpath = fullfile( maindir, subdir( i ).name, '*.png' );
    png = dir( subdirpath );               % 子文件夹下找后缀为png的文件

    for j = 1 : length( png )
        pngpath = fullfile( maindir, subdir( i ).name, png( j ).name);
        image = imread( pngpath );
        
        %bw=im2bw(image, 0.1);
        figure;imshow(image);
        processed_image = my_imageprocessing(image);
        figure;imshow(processed_image)
    end
end
