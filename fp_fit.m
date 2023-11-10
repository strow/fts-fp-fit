function [ ydata ] = fp_fit(x0,fp);
%
% fp_exelis -- build an SRF matrix from recent Exelis test data
%
% HM, 26 Jan 2014
% LLS, 27 Feb 2015: Updated with Dec 2014 Exelis focal plane

%--------------------------
% focal plane from Exelis
%--------------------------

% % side 1 x-y relative, in urad
% s1 = [
% 1    19176    19176
% 2        0    19211
% 3   -19184    19184
% 4    19194        0
% 5       0         0
% 6   -19194        0
% 7    19199   -19199
% 8        0   -19211
% 9   -19210   -19210
% ];
% 
% % % side 1 fov 5 offset, in urad
% d1 = [-582  0];
% % 
% % %d1 = d1 -[ 6.7218 -167.7077];
% % d1 = d1 -[ -167.7077 6.7218];
% 
% %d1 = [0 0];
% 
%--------------------------
% ppm offsets from gas cell fitting
%--------------------------

global ifl

%ifl = [1:4 5:9];

dy = x0(1);
dx = x0(2);
%dnu = x0(3);

% One day should update the values below??  Or check??
c = -1/36.8;
s = -1/52.2;

% Jacobian
alpha = [ c s c s 0 s c s c]';

% J1 override, using FP jacs from Howard's double difference
inv_alpha = [ -36.80  -52.20  -36.80   -52.20   Inf   -52.20  -36.80   -52.20   -36.80];
alpha = 1./inv_alpha';

% Get absolute positions from Exelis
x = fp.s(:,3) + fp.d(2);
y = fp.s(:,2) + fp.d(1);

% Change in radial positions with dx, dy
dr = ( (x(ifl) + dx).^2 + (y(ifl) + dy).^2 ).^(0.5)  - ( x(ifl).^2 + y(ifl).^2  ).^(0.5);

% Change converted to ppm
ydata = (dr.*alpha(ifl))'; % + dnu;

return

% Example fit for focal plane x,y offset
% fd.r_wmin are the ppm relative offsets from a gas cell fit.  So, fd_r_wmin(5) == 0;
% [xyoff,resnorm,residual,exitflag,output,lambda,jacobian] = lsqcurvefit(@focalplane,[0 0],[],fd.r_wmin,[],[],options);
