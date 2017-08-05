require 'paths'
paths.dofile('util.lua')
paths.dofile('img.lua')

-------------------
--- initialization
-------------------
dateset = arg[1] 
set = 'valid'
-- image_name = arg[1] 

-- load pretrained model 
m = torch.load('c2f-volumetric-h36m.t7')
m:cuda() -- change to cuda mode 

-- load h36m annotation 
a = loadAnnotations('h36m-sample')

-- forward process an image
-- local im = image.load(image_name)
