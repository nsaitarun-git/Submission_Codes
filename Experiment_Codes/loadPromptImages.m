%Function to load prompt images

function [RI_palpate,RI_ready,RI_select,RI_calibrate] = loadPromptImages(targetSize,ang,alpha)

IM_force_low = imread('dummy\dummy\force_low.png');
IM_force_medium = imread(['dummy\dummy\force_medium.png']);
IM_force_high = imread(['dummy\dummy\force_high.png']);


IM_ready = imread(['dummy\dummy\Ready.png']); 
IM_palpate = imread(['dummy\dummy\Palpate.png']);
IM_select = imread(['dummy\dummy\Select.png']); 
IM_calibrate = imread(['dummy\dummy\Calibration.png']); 

r_img = centerCropWindow2d(size(IM_force_low),targetSize);
j_img = imcrop(IM_force_low,r_img);
t_img = imrotate(j_img,ang); 
RI_force_low = imresize(t_img, alpha);

r_img = centerCropWindow2d(size(IM_force_medium),targetSize);
j_img = imcrop(IM_force_medium,r_img);
t_img = imrotate(j_img,ang); 
RI_force_medium = imresize(t_img, alpha);

r_img = centerCropWindow2d(size(IM_force_high),targetSize);
j_img = imcrop(IM_force_high,r_img);
t_img = imrotate(j_img,ang); 
RI_force_high = imresize(t_img, alpha);

r_img = centerCropWindow2d(size(IM_palpate),targetSize);
j_img = imcrop(IM_palpate,r_img);
t_img = imrotate(j_img,ang); 
RI_palpate = imresize(t_img, alpha);

r_img = centerCropWindow2d(size(IM_ready),targetSize);
j_img = imcrop(IM_ready,r_img);
t_img = imrotate(j_img,ang); 
RI_ready = imresize(t_img, alpha);

r_img = centerCropWindow2d(size(IM_select),targetSize);
j_img = imcrop(IM_select,r_img);
t_img = imrotate(j_img,ang); 
RI_select = imresize(t_img, alpha);

r_img = centerCropWindow2d(size(IM_calibrate),targetSize);
j_img = imcrop(IM_calibrate,r_img);
t_img = imrotate(j_img,ang); 
RI_calibrate = imresize(t_img, alpha);

end