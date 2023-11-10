function [fp] = get_fp(band,srf_name);
% This version removes all the foax manipulations in each FP section.
% Those changes are now reflected in fp.ppm2; I originally modified the
% foax's because the 'umbc2' 'fp.ppm' come from fits that included variable
% scaling of the focal plane radius.  This meant that I couldn't just apply
% these to focal planes with no radial shift.  However in the meantime I
% quit using variable r in the focal plane definition since Harris does not
% use it, complicating getting a good focal plane for the engr packets.
% But, it turns out that the radial change has basically no effect on the
% foax vs ppm differences.  Now the "history" of a focal plane is done
% soley with ppm differences all adding up.
%
% Do not use variable radial (r) scaling anymore when adding ppm differences, only
% use ppm diffs that come from fits with not radial scaling!!   
%    
% Remember the fp.ppm(x) are the residuals from fitting the ppm offsets
% from the fp being used *after* x,y fitting.
%   
% Use check_new_fp.m to ensure that this is correct!   

%--------------------------------------------------------------  
% Default focal plane geometry   
%--------------------------------------------------------------  
%            y             x   
   sdef = [     
      1      19198.62      19198.62
      2             0      19198.62
      3     -19198.62      19198.62
      4      19198.62             0
      5             0             0
      6     -19198.62             0
      7      19198.62     -19198.62
      8             0     -19198.62
      9     -19198.62     -19198.62 ];
%---------------------------------------------------------------------------    
%---------------------------------------------------------------------------    
   switch srf_name
%---------------------------------------------------------------------------    
%--------------------------------------------------------------    
     case 'default'
       fp.s = sdef;
       fp.d = [0 0 0];
       fp.ppm = zeros(1,9);
       fp = mod_fp(fp);
%---------------------------------------------------------------------------         
%---------------------------------------------------------------------------         
     case 'j2tvac_bad_raidial_for mod_fp'
       % Note, for MN side 1
       switch band
         %----------
         case 'LW'
           fp.s = sdef;
           fp.d = [71 -274 28];
% Observed ppm shifts
           fp.ppm = [-0.11 1.48 -0.34 -1.02 0 -0.76 -0.13 1.34 -0.15];
         %----------
         case 'MW'  % NO CHANGE: == UMBC2
           fp.s = sdef;
           fp.d = [89 -207 2.3];
% Observed ppm shifts
           fp.ppm = [-0.41 1.45 -0.73 0.30 0 0 -0.04 -0.83 1.29 -0.15];
         %----------
         case 'SW' % NO CHANGE: == UMBC2
           fp.s = sdef;
           fp.d = [46 -193  23.6];
% Observed ppm shifts
           fp.ppm = [-0.74 0.76 0.25 0.04 0 -0.14 0.12 0.86 -0.71];
       end
       fp = mod_fp(fp);
%--------------------------------------------------------------  
%---------------------------------------------------------------------------         
     case 'j2v2'
       % Update to j2tvac based on mid-Feb v2.09 (j2tvac) ILS;
       switch band
         %----------
         case 'LW'
           fp.s = sdef;
           fp.d = [71 -274 0];
           fp.d2 = [67.0  30.8 0];
           fp.d = fp.d + fp.d2;
% Observed ppm shifts
           fp.ppm = [0.64 2.02 0.42 -0.49 0 -0.23 0.61 1.87 0.60];
           fp.ppm2 = -[5.4028    3.0591    3.9594    1.4736         0    2.1237    4.0974    3.2074    4.9140];
           fp.ppm = fp.ppm + fp.ppm2;
         %----------
         case 'MW'  % NO CHANGE: == UMBC2
           fp.s = sdef;
           fp.d = [89 -207 0];
           fp.d2 = [40.4  46.6 0];
           fp.d = fp.d + fp.d2;
% Observed ppm shifts
           fp.ppm = [-0.35 1.49 -0.67 0.35 0 0 -0.77 1.34 -0.09];
           fp.ppm2 = -[3.9182    3.2894    2.5356    2.6491         0    2.6638    2.5949    2.9738    4.0136];
           fp.ppm = fp.ppm + fp.ppm2;
         %----------
         case 'SW' % NO CHANGE: == UMBC2
           fp.s = sdef;
           fp.d = [46 -192  0];
           fp.d2 = [75.9 -29.0 0];
           fp.d = fp.d + fp.d2;
% Observed ppm shifts
           fp.ppm = [-3.92 -1.49 -2.93 -2.19 0 -2.37 -3.02 -1.35 -3.86];
           fp.ppm2 = -[ 1.3128    0.4206    0.9218    0.9908         0    0.2471    0.5572    0.3780    1.6914];
           fp.ppm = fp.ppm + fp.ppm2;
       end
       fp = mod_fp(fp);
%--------------------------------------------------------------  
%---------------------------------------------------------------------------         
     case 'j2tvac'
       % Note, for MN side 1
       switch band
         %----------
         case 'LW'
           fp.s = sdef;
           fp.d = [71 -274 0];
% Observed ppm shifts
           fp.ppm = [0.64 2.02 0.42 -0.49 0 -0.23 0.61 1.87 0.60];
         %----------
         case 'MW'  % NO CHANGE: == UMBC2
           fp.s = sdef;
           fp.d = [89 -207 0];
% Observed ppm shifts
           fp.ppm = [-0.35 1.49 -0.67 0.35 0 0 -0.77 1.34 -0.09];
         %----------
         case 'SW' % NO CHANGE: == UMBC2
           fp.s = sdef;
           fp.d = [46 -192  0];
% Observed ppm shifts
           fp.ppm = [-3.92 -1.49 -2.93 -2.19 0 -2.37 -3.02 -1.35 -3.86];
       end
       fp = mod_fp(fp);
%--------------------------------------------------------------  
%--------------------------------------------------------------    
     case 'default_j1m1'
       fp.s = sdef;
       fp.d = [0 0 0];
       fp.ppm = zeros(1,9);
       switch band
          %----------
         case 'LW'
% Shift differences from default, J1
           fp.d = [-498.2 14.2 0];
% Observed ppm shifts from default, J1
           fp.ppm = -[3.15 0.45 2.41 2.49 0 2.11 2.34 4.65 3.63];
       end
       %----------
       fp = mod_fp(fp);
%---------------------------------------------------------------------------  
%---------------------------------------------------------------------------    
     case 'j1v4'
       switch band
         %----------
         case 'LW'
           fp.s = sdef;
           fp.d = [-601 -22  99];
% Shift differences from TVAC (umbc2)
           fp.d2 = [91.6 78.0 0];
           fp.d3 = [-10.3 -1.1 0];
           fp.d = fp.d + fp.d2 + fp.d3;
% Observed ppm shifts
           fp.ppm = -[7.0 3.9 4.4 3.3 0 3.2 5.1 2.9 7.2];
% fp.ppm2 are from 'umbc2' and from 'j1v1' residuals
           fp.ppm2 = -[-0.40 -0.80 1.00 1.00 0 0.50 -1.00 2.80 -2.00];
           fp.ppm3 = -[0.53 0.18 0.60 0.34  0 0.29 0.53 0.32 0.47];
           fp.ppm = fp.ppm + fp.ppm2 + fp.ppm3;
          %----------
         case 'MW'
           fp.s = sdef;
           fp.d = [-658 -10 -25];
% Shift differences from TVAC (umbc2)
           fp.d2 = [ 84.6  16.8 0];
           fp.d3 = [-11.8  5.6 0];
           fp.d = fp.d + fp.d2 + fp.d3;
% Observed ppm shifts
           fp.ppm = -[2.6  1.5 1.6 0.8 0 -0.1 1.8 0.4 3.5];
           fp.ppm2 = -[0.30 -0.60 0 0 0 0.60 -0.10 0.10 -0.30];
           fp.ppm3 = -[0.04 -0.08 -0.05 0.00 0 0.07 -0.02 -0.08 0.01];
           fp.ppm = fp.ppm + fp.ppm2 + fp.ppm3;
           %----------
         case 'SW'
           fp.s = sdef;
           fp.d = [-605  6  -63];
% Shift differences from TVAC (umbc2)
           fp.d2 = [ 87.5 -68.7 0];
           fp.d3 = [ -10.0 51.1 0];
           fp.d4 = [ -9.45 22.06 0];  % June 22, 2018
           fp.d = fp.d + fp.d2 + fp.d3 + fp.d4;
% Observed ppm shifts
           fp.ppm = -[2.2 0.8 1.0 1.7 0 1.5 0.9 1.2 2.1];
           fp.ppm2 = -[1.10 -1.40  0.50 -0.80 0 -0.60 0.20 -0.70 0.70];
           fp.ppm3 = -[-0.37 0.47 -0.22 -0.04 0 -0.03 -0.03  0.10 -0.20];
           fp.ppm = fp.ppm + fp.ppm2 + fp.ppm3;
       end
       fp = mod_fp(fp);
%---------------------------------------------------------------------------    
%---------------------------------------------------------------------------    
     case 'j1v3'
       switch band
         %----------
         case 'LW'
           fp.s = sdef;
           fp.d = [-601 -22  99];
% Shift differences from TVAC (umbc2)
           fp.d2 = [91.6 78.0 0];
           fp.d3 = [-10.3 -1.1 0];
           fp.d = fp.d + fp.d2 + fp.d3;
% Observed ppm shifts
           fp.ppm = -[7.0 3.9 4.4 3.3 0 3.2 5.1 2.9 7.2];
% fp.ppm2 are from 'umbc2' and from 'j1v1' residuals
           fp.ppm2 = -[-0.40 -0.80 1.00 1.00 0 0.50 -1.00 2.80 -2.00];
           fp.ppm3 = -[0.53 0.18 0.60 0.34  0 0.29 0.53 0.32 0.47];
           fp.ppm = fp.ppm + fp.ppm2 + fp.ppm3;
          %----------
         case 'MW'
           fp.s = sdef;
           fp.d = [-658 -10 -25];
% Shift differences from TVAC (umbc2)
           fp.d2 = [ 84.6  16.8 0];
           fp.d3 = [-11.8  5.6 0];
           fp.d = fp.d + fp.d2 + fp.d3;
% Observed ppm shifts
           fp.ppm = -[2.6  1.5 1.6 0.8 0 -0.1 1.8 0.4 3.5];
           fp.ppm2 = -[0.30 -0.60 0 0 0 0.60 -0.10 0.10 -0.30];
           fp.ppm3 = -[0.04 -0.08 -0.05 0.00 0 0.07 -0.02 -0.08 0.01];
           fp.ppm = fp.ppm + fp.ppm2 + fp.ppm3;
           %----------
         case 'SW'
           fp.s = sdef;
           fp.d = [-605  6  -63];
% Shift differences from TVAC (umbc2)
           fp.d2 = [ 87.5 -68.7 0];
           fp.d3 = [ -10.0 51.1 0];
           fp.d = fp.d + fp.d2 + fp.d3;
% Observed ppm shifts
           fp.ppm = -[2.2 0.8 1.0 1.7 0 1.5 0.9 1.2 2.1];
           fp.ppm2 = -[1.10 -1.40  0.50 -0.80 0 -0.60 0.20 -0.70 0.70];
           fp.ppm3 = -[-0.37 0.47 -0.22 -0.04 0 -0.03 -0.03  0.10 -0.20];
           fp.ppm = fp.ppm + fp.ppm2 + fp.ppm3;
       end
       fp = mod_fp(fp);
%---------------------------------------------------------------------------    
%---------------------------------------------------------------------------    
     case 'j1v2'
       switch band
         %----------
         case 'LW'
           fp.s = sdef;
           fp.d = [-601 -22  99];
% Shift differences from TVAC (umbc2)
           fp.d2 = [91.6 78.0 0];
           fp.d = fp.d + fp.d2;
% Observed ppm shifts
           fp.ppm = -[7.0 3.9 4.4 3.3 0 3.2 5.1 2.9 7.2];
% fp.ppm2 are from 'umbc2' and from 'j1v1';
           fp.ppm2 = -[-0.40  -0.80  1.00  1.00   0  0.50   -1.00   2.80  -2.00];
           fp.ppm = fp.ppm + fp.ppm2;
          %----------
         case 'MW'
           fp.s = sdef;
           fp.d = [-658 -10 -25];
% Shift differences from TVAC (umbc2)
           fp.d2 = [ 84.6  16.8 0];
           fp.d = fp.d + fp.d2;
% Observed ppm shifts
           fp.ppm = -[2.6  1.5 1.6 0.8 0 -0.1 1.8 0.4 3.5];
           fp.ppm2 = -[0.30 -0.60 0 0 0 0.60 -0.10 0.10 -0.30];
           fp.ppm = fp.ppm + fp.ppm2;
          %----------
         case 'SW'
           fp.s = sdef;
           fp.d = [-605  6  -63];
% Shift differences from TVAC (umbc2)
           fp.d2 = [ 87.5 -68.7 0];
           fp.d = fp.d + fp.d2;
% Observed ppm shifts
           fp.ppm = -[2.2 0.8 1.0 1.7 0 1.5 0.9 1.2 2.1];
           fp.ppm2 = -[1.10 -1.40  0.50 -0.80 0 -0.60 0.20 -0.70 0.70];
           fp.ppm = fp.ppm + fp.ppm2;
       end
       fp = mod_fp(fp);
%---------------------------------------------------------------------------         
%---------------------------------------------------------------------------         
     case 'j1v1'
       switch band
         %----------
         case 'LW'
           fp.s = sdef;
           fp.d = [-601 -22  99];
% Observed ppm shifts
           fp.ppm = [0 0 0 0 0 0 0 0 0];
           fp.ppm2 = -[-0.40 -0.80 1.00 1.00 0 0.50 -1.00 2.80 -2.00];
           fp.ppm = fp.ppm + fp.ppm2;
         %----------
         case 'MW'  % NO CHANGE: == UMBC2
           fp.s = sdef;
           fp.d = [-658 -10 -25];
% Observed ppm shifts
           fp.ppm = [0 0 0 0 0 0 0 0 0];
           fp.ppm2 = -[0.30 -0.60 0 0 0 0.60 -0.10 0.10 -0.30];
           fp.ppm = fp.ppm + fp.ppm2;
         %----------
         case 'SW' % NO CHANGE: == UMBC2
           fp.s = sdef;
           fp.d = [-605  6  -63];
% Observed ppm shifts
           fp.ppm = [0 0 0 0 0 0 0 0 0];
           fp.ppm2 = -[1.10 -1.40 0.50 -0.80 0 -0.60 0.20 -0.70 0.70];
           fp.ppm = fp.ppm + fp.ppm2;
       end
       fp = mod_fp(fp);
%--------------------------------------------------------------    
%--------------------------------------------------------------  
     case 'umbc1'
       switch band
         %----------
         case 'LW'
           fp.s = sdef;
           fp.d = [-606 -31];
           fp.ppm = [0 0 0 0 0 0 0 0 0];
        %----------
        case 'MW'
           fp.s = sdef;
           fp.d = [-658 -32];
           fp.ppm = [0 0 0 0 0 0 0 0 0];
         %----------
         case 'SW'
           fp.s = sdef;
           fp.d = [-614 -10];
           fp.ppm = [0 0 0 0 0 0 0 0 0];
       end
       fp = mod_fp(fp);
%--------------------------------------------------------------  
%--------------------------------------------------------------  
     case 'umbc2'
       switch band
         %----------
         case 'LW'
           fp.s = sdef;
           dnew = [5 9 99];  % add these to umbc1
% From umbc1 MN LW (after r fit)
           fp.ppm = [0.4 0.8 -1.0 -1.0 0 -0.5 1.0 -2.8 2.0];
           fp.d = [-606 -31 0] + dnew;
         %----------
         case 'MW'
           fp.s = sdef;
           dnew = [0 22 -25];
           fp.ppm = [-0.3 0.6 0 0 0 -0.6 0.1 -0.1 0.3];
           fp.d = [-658 -32 0] + dnew;
         %----------
         case 'SW'
           fp.s = sdef;
           dnew = [9 16 -63];
           fp.d = [-614 -10 0] + dnew;
           fp.ppm = [-1.1 1.4 -0.5 0.8 0 0.6 -0.2 0.7 -0.7];
       end
       fp = mod_fp(fp);
%--------------------------------------------------------------  
%--------------------------------------------------------------  
     case 'npp'
% dg_v33a_* are the NPP focal planes.  These do NOT break out the
% radial shift.  Instead it is implemented via residual./alpha where
% residual is what's left after an x,y shift.  So, below fp.d(3) is set
% to zero and fp.s has the radial scaling built-in
% Note that I am switching signs on the offsets below from the past
% so to be compatible with engr packet and other FP's in this routine
       switch band
         %----------
         case 'LW'
           load /asl/matlib/cris/dg_v33a_lw
         %----------
         case 'MW'  % NO CHANGE: == UMBC2
           load /asl/matlib/cris/dg_v33a_mw
         %----------
         case 'SW' % NO CHANGE: == UMBC2
           load /asl/matlib/cris/dg_v33a_sw
       end
       fp.foax_from_dg = dg.s';
       fp.s(:,1) = 1:9;
       fp.s(:,2) = dg.sy*1E6;
       fp.s(:,3) = dg.sx*1E6;
       fp.d(1) = -1E6*dg.align_offset_y;
       fp.d(2) = -1E6*dg.align_offset_x;
       fp.d(3) = 0;  % by definition
       fp.rad = dg.Rtheta*1E6;
       fp.ppm = [0 0 0 0 0 0 0 0 0];  % already applied
       fp = mod_fp(fp);
%--------------------------------------------------------------  
%--------------------------------------------------------------  
     case 'npp2'
% dg_v33a_* are the NPP focal planes.  These do NOT break out the
% radial shift.  Instead it is implemented via residual./alpha where
% residual is what's left after an x,y shift.  So, below fp.d(3) is set
% to zero and fp.s has the radial scaling built-in
% Note that I am switching signs on the offsets below from the past
% so to be compatible with engr packet and other FP's in this routine
       switch band
         %----------
         case 'LW'
           load /asl/matlib/cris/dg_v33a_lw
         %----------
         case 'MW'  % NO CHANGE: == UMBC2
           load /asl/matlib/cris/dg_v33a_mw
         %----------
         case 'SW' % NO CHANGE: == UMBC2
           load /asl/matlib/cris/dg_v33a_sw
       end
       fp.foax_from_dg = dg.s';
       fp.s(:,1) = 1:9;
       fp.s(:,2) = dg.sy*1E6;
       fp.s(:,3) = dg.sx*1E6;
       fp.d(1) = -1E6*dg.align_offset_y;
       fp.d(2) = -1E6*dg.align_offset_x;
       fp.d(3) = 0;  % by defnition
     switch band
     case 'LW'
       fp.d2 = -[-12.7 -30.2 -10];  % SIGNS?  Note radial change
       fp.d = fp.d + fp.d2;
     case 'MW'
       fp.d2 = -[-6.8 -30.7 7.9];  % SIGNS?  Note radial change
       fp.d = fp.d + fp.d2;
     case 'SW'
       fp.d2 = -[-0.2 -16.4 6.7];  % SIGNS?  Note radial change
       fp.d = fp.d + fp.d2;
   end       

%   FOR NOW fp.d2 same for all bands, soon switch out to LW/MW/SW
       fp.rad = dg.Rtheta*1E6;
       fp.ppm = [0 0 0 0 0 0 0 0 0];  % already applied
       fp = mod_fp(fp);
%--------------------------------------------------------------  
%--------------------------------------------------------------  
     case 'npp2_perfect'
% dg_v33a_* are the NPP focal planes.  These do NOT break out the
% radial shift.  Instead it is implemented via residual./alpha where
% residual is what's left after an x,y shift.  So, below fp.d(3) is set
% to zero and fp.s has the radial scaling built-in
% Note that I am switching signs on the offsets below from the past
% so to be compatible with engr packet and other FP's in this routine
       switch band
         %----------
         case 'LW'
           load /asl/matlib/cris/dg_v33a_lw
         %----------
         case 'MW'  % NO CHANGE: == UMBC2
           load /asl/matlib/cris/dg_v33a_mw
         %----------
         case 'SW' % NO CHANGE: == UMBC2
           load /asl/matlib/cris/dg_v33a_sw
       end
       fp.foax_from_dg = dg.s';
       fp.s(:,1) = 1:9;
       fp.s(:,2) = dg.sy*1E6;
       fp.s(:,3) = dg.sx*1E6;
       fp.d(1) = -1E6*dg.align_offset_y;
       fp.d(2) = -1E6*dg.align_offset_x;
       fp.d(3) = 0;  % by defnition
     switch band
     case 'LW'
       fp.d2 = -[-33.9 -36.2 0];  % SIGNS?  Note radial change
       fp.d = fp.d + fp.d2;
     case 'MW'
       fp.d2 = -[14.0 -28.0 -4.1];  % SIGNS?  Note radial change
       fp.d = fp.d + fp.d2;
     case 'SW'
       fp.d2 = -[-5.4 -16.9 -8.4];  % SIGNS?  Note radial change
       fp.d = fp.d + fp.d2;
   end       

%   FOR NOW fp.d2 same for all bands, soon switch out to LW/MW/SW
       fp.rad = dg.Rtheta*1E6;
       fp.ppm = [0 0 0 0 0 0 0 0 0];  % already applied
       fp = mod_fp(fp);
%--------------------------------------------------------------  
%--------------------------------------------------------------  
     case 'exelis'  
% This is J1 exelis TVAC values (and at-launch engr pkt values)
       switch band
         %----------
         case 'LW'
           fp.s = [
              1    19193    19193
              2        0    19283
              3   -19173    19173
              4    19256        0
              5       0         0
              6   -19256        0
              7    19342   -19342
              8        0   -19283
              9   -19354   -19354];
           fp.d = [-516  91  0];
         %----------
         case 'MW'
           fp.s = [
              1    19176    19176
              2        0    19211
              3   -19184    19184
              4    19194        0
              5       0         0
              6   -19194        0
              7    19199   -19199
              8        0   -19211
              9   -19210   -19210
                  ];
           fp.d = [-582  0  0];
         %----------
         case 'SW'
           fp.s = [
              1    19125    19125
              2        0    19182
              3   -19136    19136
              4    19194        0
              5       0         0
              6   -19168        0
              7    19164   -19164
              8        0   -19182
              9   -19156   -19156
                  ];
           fp.d = [-578  13  0];
       end
       fp.ppm = zeros(1,9);
       fp = mod_fp(fp);
   end
%--------------------------------------------------------------  
%--------------------------------------------------------------  
end
%--------------------------------------------------------------  
%--------------------------------------------------------------  
function fp = mod_fp(fp);
   dr = fp.d(3);
   fpang = atan2(fp.s(:,2),fp.s(:,3));
   id = [1:4 6:9];  % FOV5 angle no good and not needed
   fp.s(id,3) = fp.s(id,3) + dr.*cos(fpang(id));
   fp.s(id,2) = fp.s(id,2) + dr.*sin(fpang(id));
% Default Jacobians, over-ridden below by J1 specific Jacobians
% However the differences are so small it doesn't matter   
%    c     = -1/36.8;
%    s     = -1/52.2;
%    alpha = [ c s c s 0 s c s c];
% J1 override, using FP jacs from Howard's double difference
   inv_alpha = [ -36.80  -52.20  -36.80   -52.20   Inf   -52.20  -36.80   -52.20   -36.80];
   alpha = 1./inv_alpha;
% This is individual dr, starting with fp.ppm (ppm units)
   dr = -(fp.ppm./alpha)';
   dr(5) = 0;  % So, no id needed here
   fp.s(:,3) = fp.s(:,3) + dr.*cos(fpang(:));
   fp.s(:,2) = fp.s(:,2) + dr.*sin(fpang(:));
% Compute foax (all needed for ccast, in ccast units)
   fp.foax = sqrt( (fp.s(:,3) + fp.d(2)).^2 + (fp.s(:,2) + fp.d(1)).^2);
   fp.foax = 1E-6*fp.foax;  % compatible with ccast
end
%--------------------------------------------------------------  
%--------------------------------------------------------------  
