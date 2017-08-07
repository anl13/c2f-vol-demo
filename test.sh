#!/usr/bin/sh

data_name="/home/al17/dataset/anliang_kinect2/c100.png"
outh5_name="pred/anliang_kinect2_c100.h5"
centerx=996 # along the row 
centery=515 # along the col 
s=2.7

th test.lua ${data_name} ${outh5_name} ${centerx} ${centery} ${s}
