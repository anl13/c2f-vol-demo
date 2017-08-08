%% created on 2017/Aug/05 by An Liang, THU
%  used to display a single image with 3D skeleton extracted by c2f-volumetric network.
%  i.e. show only one '.h5' file which stores skeleton coordinates. 
function [] = demoImage(imagename, predpath, center, scale)

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

disp(imagename);
I = imread(imagename);
bbox = getHGbbox(center, scale);
img_crop = cropImage(I, bbox);

% read network's output and plot it
joints = hdf5read(predpath, 'preds3D');
x = joints(1, :);
y = joints(2, :);
z = joints(3, :);
figure(1); 
% scatter3(x,y,z, ones(size(x)), 'filled');
plot3(x,y,z,'.');

% pixel location
W = maxLocation(joints(1:2,:), bbox, [outputRes, outputRes]);
% depth(relative to root) 
Zrel = Zcen(joints(3, :));

% camera calibration matrix 
K_kinect2 = [1063.26, 0, 969.429; 
    0, 1062.1, 546.539; 
    0, 0, 1]; 

K = K_kinect2;
% reconstruct 3D skeleton 
if recType == 1
    % S = estimate3D(W, Zrel, K, zroot); 
elseif recType == 2
%     S = estimate3D(W, Zrel, K, Lgt, skel); 
elseif recType == 3
    S = estimate3D (W, Zrel, K, Ltr, skel);
end


% visualization 
nPlot = 3;        % plot 3 sub windows in main window 
h = figure('position', [300 300 200*nPlot 200]);  % define figure 
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

end

