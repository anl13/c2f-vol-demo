%% created on 2017/Aug/05 by An Liang, THU
%  used to display a single image with 3D skeleton extracted by c2f-volumetric network.
%  i.e. show only one '.h5' file which stores skeleton coordinates. 

%  start; 
clear; startup; 

%  define paths for basic skeleton info, e.g. skeleton topology definition, limblength 
%  prior, etc. As well, it stores the ground truth of demo image.
annotfile = '../data/h36m-sample/annot/valid.mat'; 
load(annotfile);  % loaded data stored in 'annot' variable

%  imagepath and predictionpath 
imagepath = '../data/h36m-sample/images/S9_Posing_1.54138969_000001.jpg';
predpath = '../test.h5';

%  define the reconstruction from the volumetric representation 
%  if recType = 3, we estimate the root depth based on the training subjects' mean skeleton size
recType = 3

%  volume parameter
outputRes = 64;   % x, y resolution 
depthRes = 64;    % z resolution 
numKps = 17;      % number of joints (key points) 

%  read network output and visualize it
nPlot = 3;        % plot 3 sub windows in main window 
h = figure('position', [300 300 200*nPlot 200]);  % define figure 

%  read input info from annot 
%  the image I tested is the 1st one 
center = annot.center(1,:);
scale = annot.scale(1);
Sgt = squeeze(annot.S(1,:,:)); % Skeleton ground truth 
K = annot.K{1}; 
