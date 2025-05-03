clc;clear;close all;
%% Load faces

% Load white male images
for n = 1: 100
    IM_WM{n} = imread(['wm_1\wm_1\' num2str(n) '.png']);
end

% Load white female images
for n = 1: 100
    IM_WW{n} = imread(['wf_1\wf_1\' num2str(n) '.png']);
end

%% Play faces
delay = 0.001;
for i=1:100
    subplot(1,2,1)
    imshow(IM_WM{i})
    title("Male Pain Expressions","FontSize",16)
    subplot(1,2,2)
    imshow(IM_WW{i})
    title("Female Pain Expressions","FontSize",16)
    pause(delay)
end