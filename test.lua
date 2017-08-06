-- load necessary libraries 
require 'paths'
paths.dofile('util.lua')
paths.dofile('img.lua')

-------------------
--- initialization
-------------------

-- used for load skeleton annotation 
-- TODO: remove these dependency on irrelevant dataset name 
dateset = 'h36m-sample' 
set = 'valid'
a = loadAnnotations('h36m-sample')

-- load pretrained model 
m = torch.load('c2f-volumetric-h36m.t7')
m:cuda() -- change to cuda mode 


-- forward process an image
-- local im = image.load(image_name)
image_name = arg[1] -- input image for process 
h5_name = arg[2]    -- output filename 
center = torch.Tensor(2)
center[1] = arg[3]  -- vertical center of human  
center[2] = arg[4]  -- horizontal center of human 
scale = arg[5]      -- human bbox size / 200

im = image.load(image_name)
inp = crop(im, center, scale, 0, 256)

-- Get network output 
out3D = m:forward(inp:view(1,3,256,256):cuda())
out3D = applyFn(function (x) return x:clone() end, out3D[#out3D])
flipped = m:forward(flip(inp:view(1,3,256,256):cuda()))
flipped = applyFn(function (x) return flip(shuffleLR(x)) end, flipped[#flipped])
out = applyFn(function (x,y) return x:add(y):div(2) end, out3D, flipped)

preds3D = torch.Tensor(1,17,3)
predHMs = torch.Tensor(1,17*64,64,64)

predHMs:copy(out)
preds3D:copy(getPreds3D(out))

predFile = hdf5.open(h5_name, 'w')
predFile:write('preds3D', preds3D)
predFile:close() 
