#!/usr/bin/sh

#data_name='/home/al17/Pictures/seq/rgb_0.jpg';
#pred_name='pred/seq_rgb_0.h5';
centerx=733;
centery=610;
s=3.6;

#th test.lua ${data_name} ${pred_name} ${centerx} ${centery} ${s}
th test.lua ${centerx}  ${centery} ${s}
