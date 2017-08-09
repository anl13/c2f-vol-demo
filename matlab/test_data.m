%% provide data for demoImage(..)
% usage: test_data; demoImage(datax, predx, cx,sx,Kx);

% test image of demo picture
data1 = '../exp/h36m-sample/normal/img1.jpg';
pred1 = '../exp/h36m-sample/normal/valid_1.h5';
c1 = [509.0518, 409.5840];
s1 = 1.9063;
K1 = [1149.7, 0, 508.8;
    0,1147.6, 508.1;
    0,0,1];

% data2
data2 = '/home/al17/dataset/anliang_kinect2/c103.png';
pred2 = '../pred/anliang_kinect2_c103.h5';
c2 = [996, 540]; 
s2 = 2.6;
K2 = [1063.26, 0, 969.429;
    0, 1062.1, 546.539;
    0, 0, 1];

