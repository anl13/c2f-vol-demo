#!/usr/bin/sh

data_name="/home/al17/dataset/anliang_kinect2/c103.png"
outh5_name="pred/anliang_kinect2_c103.h5"
centerx=996 # along the row 
centery=540 # along the col 
s=2.6

th test.lua ${data_name} ${outh5_name} ${centerx} ${centery} ${s}
