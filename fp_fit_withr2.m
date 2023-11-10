function [ ppm ] = fp_fit_withr2(x0,fp);

% CrIS focal plane derivative for:
% x,y offset ( x0(2), x0(1) )
% radial magnification, dr,  ( x0(3) )
% Neon shift ( x0(4) ); 
% Give focal plane ( fp )
% Output is ppm shift give these inputs

global ifl

%ifl = [1:4 6:9];

dy = x0(1);
dx = x0(2);
drr = x0(3);
%dnu = x0(4);

% One day should update the values below??  Or check?? (I think I did...)
c = -1/36.8;
s = -1/52.2;

% Jacobian
alpha = [ c s c s 0 s c s c]';

% J1 override, using FP jacs from Howard's double difference (MAKES NO DIFFERENCE)
inv_alpha = [ -36.80  -52.20  -36.80   -52.20   Inf   -52.20  -36.80   -52.20   -36.80];
alpha = 1./inv_alpha';

% Get absolute positions
x = fp.s(:,3) + fp.d(2);
y = fp.s(:,2) + fp.d(1);

% Change in radial positions with dx, dy, dr
%dr = ( (x(ifl) + dx).^2 + (y(ifl) + dy).^2 ).^(0.5)  - ( x(ifl).^2 + y(ifl).^2  ).^(0.5) + drr;
id = [1:4 6:9];
fpang = atan2(fp.s(:,2),fp.s(:,3));
drx = ones(9,1); dry = ones(9,1);
drx(id) = drr.*cos(fpang(id));
dry(id) = drr.*sin(fpang(id));

drx = drx(ifl);
dry = dry(ifl);

dr = ( (x(ifl) + dx + drx).^2 + (y(ifl) + dy + dry).^2 ).^(0.5)  - ( x(ifl).^2 + y(ifl).^2  ).^(0.5) ;

% Change converted to ppm
ppm = (dr.*alpha(ifl))';% + dnu;

return

% Example fit for focal plane
% [xyoff,resnorm,residual,exitflag,output,lambda,jacobian] = lsqcurvefit(@fp_fit_withr,[0 0 0 0],ppm_obs,lb,ub,options)
