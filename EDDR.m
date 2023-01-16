
%To detect Eyes 

EyeDetect = vision.CascadeObjectDetector('EyePairBig');

%Read the input Image
Image = imread('4.jpg');
subplot(1,2,1), imshow(Image);

BB = step(EyeDetect,Image);
for i = 1:size(BB,1)
    rectangle('Position',BB,'LineWidth',3,'LineStyle','-','EdgeColor','r');
end
title('Detected Eyes');
Eyes = imcrop(Image,BB);
subplot(1,2,2), imshow(Eyes);
title('Enhanced abstract View');

%allow if masked

I = imread('4.jpg');
faceDetector = vision.CascadeObjectDetector;
bboxes = step(faceDetector, I);
IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Face');
figure
imshow(IFaces), title('Detected faces');



%Image Processing
Test_Image = imread('Test Images/2_right.jpeg');
Resized_Image = imresize(Test_Image, [584 565]);
Converted_Image = im2double(Resized_Image);
Lab_Image = rgb2lab(Converted_Image);
fill = cat(3, 1,0,0);
Filled_Image = bsxfun(@times, fill, Lab_Image);
Reshaped_Lab_Image = reshape(Filled_Image, [], 3);
[C, S] = pca(Reshaped_Lab_Image);
S = reshape(S, size(Lab_Image));
S = S(:, :, 1);
Gray_Image = (S-min(S(:)))./(max(S(:))-min(S(:)));
Enhanced_Image = adapthisteq(Gray_Image, 'numTiles', [8 8], 'nBins', 128);
Avg_Filter = fspecial('average', [9 9]);
Filtered_Image = imfilter(Enhanced_Image, Avg_Filter);
figure, imshow(Filtered_Image)
title('Filtered view of eye segmentation')
Substracted_Image = imsubtract(Filtered_Image,Enhanced_Image);

level = Threshold_Level(Substracted_Image);
 
Binary_Image = imbinarize(Substracted_Image, level-0.008);
figure, imshow(Binary_Image)
title('Binary dispersion of retina convolution')
 
Clean_Image = bwareaopen(Binary_Image, 100);
figure, imshow(Clean_Image)
title('Featured analysis of respawn image')

Complemented_Image = imcomplement(Clean_Image);
figure, imshow(Complemented_Image)
title('Complemented layer of neural segments')
 
Final_Result = Colorize_Image(Resized_Image, Complemented_Image, [0 0 0]);
figure, imshow(Final_Result)
title('Insight Polarisation View')

Final_Result = Colorize_Image(Resized_Image, Complemented_Image, [1 1 1]);
figure, imshow(Final_Result)
title('Non-Proliferative Diabetic Retinopathy')



