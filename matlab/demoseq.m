
%  start; 
startup; 

%  define paths for basic skeleton info, e.g. skeleton topology definition, limblength 
%  prior, etc. As well, it stores the ground truth of demo image.
% annotfile = '../data/h36m-sample/annot/valid.mat'; 
% load(annotfile);  % loaded data stored in 'annot' variable
% disp(annotfile);
%  imagepath and predictionpath 
% imagepath = '../data/h36m-sample/images/S9_Posing_1.54138969_000001.jpg';
% predpath = '../test.h5';

%  define the reconstruction from the volumetric representation 
%  if recType = 3, we estimate the root depth based on the training subjects' mean skeleton size
recType = 3; 

%  volume parameter
outputRes = 64;   % x, y resolution 
depthRes = 64;    % z resolution 
numKps = 17;      % number of joints (key points) 


%  read input info from annot 
%  the image I tested is the 1st one 
% center = annot.center(1,:);
% scale = annot.scale(1);
% Sgt = squeeze(annot.S(1,:,:)); % Skeleton ground truth 
% K = annot.K{1}; 
% read network's output and plot it
r = [2,3,4,12,13,14]; % right part of body, in green 
l = [5,6,7,15,16,17]; % left part of body , in red
b = [1,8,9,10,11];    % central part of body, in blue

v = VideoWriter('seq.avi','Motion JPEG AVI');
v.FrameRate = 5;
v.VideoCompressionMethod
open(v);

% center = [270, 210];
% scale = 1.8;
center = [733, 610];
scale = 3.6;

K_astra = [576.251, 0, 313.154;
    0, 577.558, 249.936;
    0, 0, 1];

K_Kinect2 = [1149.7, 0, 508.8;  
    0,1147.6, 508.1;
    0,0,1];
K = K_Kinect2;

im_size = [230, 610];

nPlot = 3;
h = figure('position',[300 300 200*nPlot 200]);
for i=1:148
    imagename=sprintf('/home/al17/Pictures/boy2/c%d.png', i);
    predname = sprintf('../pred/pred_%d.h5', i);
    I = imread(imagename);
    bbox = getHGbbox(center, scale);
    img_crop = cropImage(I, bbox);

    joints = hdf5read(predname, 'preds3D');
    %x = joints(1, :);
    %y = 64 - joints(2, :); % flip y 
    %z = joints(3, :);
    %figure(1); 
% scatter3(x,y,z, ones(size(x)), 'filled');
    %plot(y(r),z(r), '.g','MarkerSize', 20); hold on;
    %plot(y(l),z(l), '.r','MarkerSize', 20); hold on;
    %plot(y(b),z(b), '.b','MarkerSize', 20); 
    %axis([0 64 0 64]);
    %xlabel('y');ylabel('z');% zlabel('z');

    %figure(2);

    %plot(x(r),y(r),'.g','MarkerSize', 20); hold on;
    %plot(x(l),y(l),'.r','MarkerSize', 20); hold on;
    %plot(x(b),y(b),'.b','MarkerSize', 20); 
    %axis([0 64 0 64]);xlabel('x');ylabel('y');

    % pixel location
    W = maxLocation(joints(1:2,:), bbox, [outputRes, outputRes]);
    % depth(relative to root) 
    Zrel = Zcen(joints(3, :));

    % reconstruct 3D skeleton 
    if recType == 1
        % S = estimate3D(W, Zrel, K, zroot); 
    elseif recType == 2
    %     S = estimate3D(W, Zrel, K, Lgt, skel); 
    elseif recType == 3
        S = estimate3D (W, Zrel, K, Ltr, skel);
    end

    clf;
    % visualization 
    % cropped raw image
    subplot('position', [0/nPlot 0 1/nPlot 1]);
    imshow(img_crop); hold on; 
    % 3D reconstructed pose 
    subplot('position', [1/nPlot 0 1/nPlot 1]);
    vis3Dskel(S, skel);
    % 3D reconstructed pose in new view 
    subplot('position', [2/nPlot 0 1/nPlot 1]);
    vis3Dskel(S, skel, 'viewpoint', [-90, 0]);
    camroll(10);

    if i>0
        frame = getframe(gcf);
        im=frame2im(frame);
        im = imresize(im, im_size);
        writeVideo(v,im);
    end 
    pause(0.01);
end
close(v);