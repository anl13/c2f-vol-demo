%% provide data for demoImage(..)
% usage: test_data; demoImage(datax, predx, cx,sx,Kx);
K_astra1 = [576.251, 0, 313.154;
    0, 577.558, 249.936;
    0, 0, 1];

K_astra2 = [512.408, 0, 327.955;
    0, 512.999, 236.763;
    0,0,1];
% test image of demo picture
data1 = '../exp/h36m-sample/normal/img1.jpg';
pred1 = '../exp/h36m-sample/normal/valid_1.h5';
c1 = [509.0518, 409.5840];
s1 = 1.9063;
K1 = [1149.7, 0, 508.8;  % kinect2 
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

% data3 
data3 = '../exp/h36m-sample/cut_head/raw_data_1.jpg';
pred3 = '../exp/h36m-sample/cut_head/valid_1.h5';
c3 = c1 + [0, 100];
s3 = s1;
K3 = K1;

% data4 
data4 = '../exp/h36m-sample/larger_window/raw_data_1.jpg';
pred4 = '../exp/h36m-sample/larger_window/valid_1.h5';
c4 = c1;
s4 = s1+1;
K4 = K1;

% data5
data5='/home/al17/Pictures/girl/rgb_14.jpg';
pred5='../pred/rgb_14.h5';
c5=[308, 200];
s5 = 0.95;
K5 = K_astra1;

% data6 
data6='/home/al17/Pictures/boy/rgb_5.jpg';
pred6 = '../pred/rgb_5.h5';
c6 = [290,250];
s6 = 2.05;
K6 = K5; 

% datacmu 
data7='../data/cmu/frame0.jpg';
pred7='../pred/frame0.h5';
c7=[162, 123];
s7=0.6;
K7 = [400, 0, 162; 0, 400, 123; 0,0,1];