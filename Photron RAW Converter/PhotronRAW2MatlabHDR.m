function PhotronRAW2MatlabHDR(input_filename, Resolution)
% takes the input RAW file taken from the Photron Highspeed camera and 
% saves it as a matlab friendly HDR file for future processing. the matlab
% HDR is made of single precision values from 0 to 1

% Resolution - a 1x2 matrix containing the [width height] of the image

row=Resolution(1,2);  col=Resolution(1,1);
fin=fopen(sprintf('%s.raw',input_filename),'r');
I=fread(fin, col*row*3,'uint16=>uint16'); %// Read in as a single byte stream
I = im2single(I);

R_channel = I(1:3:length(I));
G_channel = I(2:3:length(I));
B_channel = I(3:3:length(I));

I = cat(3,R_channel, G_channel, B_channel);
I = reshape(I, [col row 3]); %// Reshape so that it's a 3D matrix - Note that this is column major
I_new = cat(3, I(:,:,3), I(:,:,2), I(:,:,1));
Ifinal = flip(imrotate(I_new, -90),2); % // The clever transpose

% rgb = tonemap(Ifinal);
% figure(1)
% imshow(rgb)
% fclose(fin); %// Close the file
hdrwrite(Ifinal,sprintf('%s.hdr',input_filename))
end
