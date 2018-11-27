%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program help generate a raster scan pattern with customed
% parameters. Please add the file to matlab path and run it. A text file
% including the pattern data named 'test.smp' would be generated under your current path. 
%
% The pattern contaiens a vertical 'escape line' located at x=-1 (the left side of the scene).
% The ranges for x and y are both from -1 to 1. So please set the
% x_amplitude and y_amplitude between 0 to 1. Note that don't set
% x_amplitude so close to 1, which makes the 'escape line' so close to the
% scan pattern. You can rotate the figure to see the x-y plan that shows
% the pattern. Double check all of the data are within 0<x<1 and 0<y<1
% before importing the .smp file to mirrocleDraw. edit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all;close all;clc

%%%%prarameters that could be set up%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
line=48; % number of vertical lines of the scan pattern
datapoints_x=520;% number of datapoints for each verical line
x_amplitude=0.7; %amplitude for vertical direction, should be value from(0 to 1), 
                  %don't set to 1. The closer this value set to 1, the less distance 
                  %between pattern and escape line would be.
y_amplitude=0.7; %amplitude for horizontal direction, should be the same as x_amplitude
                 %if want to get a square scan pattern.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%length of space between two adjacent lines
length_vertical=(2*y_amplitude)/(line-1);  
% length of each step in x direction
step_x=(2*x_amplitude)/(datapoints_x-1);  

%generate datapoints for each horizontal line, from left to right (reverse for right to left)
x=zeros(datapoints_x,1);
y=zeros(line,1);
for i=1:datapoints_x
    x_value=-x_amplitude+(i-1)*step_x;
    x(i,1)=x_value;
end
x_reverse=flipud(x);

for j=1:line
    y_value_on_line=y_amplitude-(j-1)*length_vertical;
    y(j,1)=y_value_on_line;
end
    
coordinates=[];
loop_number=line/2;
for i=1:loop_number
   
    if i~=loop_number
        x1=x;    % x values on line
        y1=ones(size(x))*y(2*i-1,1);  % y values on  upper line
        %z1=255*ones(size(x,1));
        temp1=[x1,y1];
        %coordinates=[coordinates;temp1];
        
% % %         x2=x_amplitude*ones(datapoints_y,1);
% % %         y2=[];
% % %         %z2=zeros(size(x2,1));
% % %         for k=1:datapoints_y
% % %             y2(k,1)=y(2*i-1)-k*length_vertical;
% % %         end
% % %         temp2=[x2,y2];  % last y2 values should = y values on lower line
% % %         %coordinates=[coordinates;temp2];
        
        
        x3=x_reverse;    % x values on line
        y3=ones(size(x))*y(2*i,1);  % y values on lower line
        %z3=zeros(size(x3,1));
        temp3=[x3,y3];
           
% % %         x4=-x_amplitude*ones(datapoints_y,1);
% % %         y4=[];
% % %         for k=1:datapoints_y
% % %             y4(k,1)=y(2*i)-k*length_vertical;
% % %         end
% % %         %z4=zeros(size(x4,1));
% % %         temp4=[x4,y4];  % last y4 values should = y values on next upper line
        coordinates=[coordinates;[temp1;temp3]];
        
        
        
    elseif i==loop_number
        x1=x;    % x values on line
        y1=ones(size(x))*y(2*i-1,1);  % y values on  upper line
        %z1=255*ones(size(x,1));
        temp1=[x1,y1];
        %coordinates=[coordinates;temp1];
        
% % %         x2=x_amplitude*ones(datapoints_y,1);
% % %         y2=[];
% % %         %z2=zeros(size(x2,1));
% % %         for k=1:datapoints_y
% % %             y2(k,1)=y(2*i-1)-k*length_vertical;
% % %         end
% % %         temp2=[x2,y2];  % last y2 values should = y values on lower line
% % %         %coordinates=[coordinates;temp2];
        
        
        x3=x_reverse;    % x values on line
        y3=ones(size(x))*y(2*i,1);  % y values on lower line
        %z3=zeros(size(x3,1));
        temp3=[x3,y3];
        
        
        coordinates=[coordinates;[temp1;temp3]];
     end
end
z=255*ones(size(coordinates,1),1);

pattern=[coordinates z];




gap_datapoints=50;
gap=1-x_amplitude;
gap_step=gap/gap_datapoints;
background_datapoints=100;
back_x=-1;
back_y_step=2*y_amplitude/background_datapoints;

gap1=zeros(gap_datapoints,3);
back=zeros(background_datapoints,3);
gap2=zeros(gap_datapoints,3);

for i=1:gap_datapoints+1
    gap1(i,1)=-x_amplitude-(i-1)*gap_step;
    gap1(i,2)=-y_amplitude;
    gap1(i,3)=0;
end
for r=1:background_datapoints+1
    back(r,1)=back_x;
    back(r,2)=-y_amplitude+(r-1)*back_y_step;
end
for i=1:gap_datapoints+1
    gap2(i,1)=-1+(i-1)*gap_step;
    gap2(i,2)=y_amplitude;
    gap2(i,3)=0;
end
back_to_start=[-x_amplitude,y_amplitude,255];

final=[pattern;gap1; back;gap2;back_to_start];
final_x=final(:,1);
final_y=final(:,2);
final_z=final(:,3);

figure
plot3(final_x,final_y,final_z,'o-');
xlabel('x')
ylabel('y')
zlabel('z')

fid=fopen('test.smp','wt');
[m,n]=size(final);
for a=1:m
    for b=1:n
        if b==n
            fprintf(fid,'%g\n',final(a,b));
        else
            fprintf(fid,'%g\t',final(a,b));
        end
    end
end
fclose(fid);

 

