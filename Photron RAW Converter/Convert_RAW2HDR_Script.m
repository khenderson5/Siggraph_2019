% place the two files Convert_RAW2HDR_Script.m and PhotronRAW2MatlabHDR.m
% into the folder containing all of the RAW files from the Photron camera.
% change the image resolution in this file to math that of the captured RAW
% files. By running Convert_RAW2HDR_Script.m, the RAW files will be saved
% as HDR files for processing in MATLAB
Image_Resolution = [1024 1024];
list = dir('*.raw');

for i = 1:length(list)
[filepath,name,ext] = fileparts(list(i).name);


PhotronRAW2MatlabHDR(name, Image_Resolution)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% display the image if desired
% hdr = hdrread(sprintf('%s.hdr',name));
% rgb = tonemap(hdr);
% figure(1)
% imshow(rgb)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
