#!/usr/bin/sh

#data_name="/home/al17/dataset/anliang_kinect2/c103.png"
#outh5_name="pred/anliang_kinect2_c103.h5"
#centerx=996 # along the row 
#centery=540 # along the col 
#s=2.6

#data_name='/home/al17/Pictures/human1.jpg';
#outh5_name='pred/human1.h5';
#centerx=172;
#centery=220;
#s=1.9;

#data_name='/home/al17/Pictures/boy/rgb_5.jpg';
#pred_name='pred/rgb_5.h5';
#centerx=290;
#centery=250;
#s=2.05;

data_name='data/cmu/frame0.jpg';
pred_name='pred/frame0.h5';
centerx=162;
centery=123;
s=0.6;
th test.lua ${data_name} ${pred_name} ${centerx} ${centery} ${s}
