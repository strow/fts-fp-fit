function [] = fit_print(ppm,x,x_r,ci,ci_r,res,res_r);

   fprintf('\n');
   y = lin_to_fp(ppm);
   fprintf('%s\n',['          ppm'])
   for i=1:3
      fprintf('%7.1f %7.1f %7.1f \n',y(i,:))
   end

   fprintf('\n');
   y = lin_to_fp(res_r);
   fprintf('%s\n',['Fit with r residuals:'])
   for i=1:3
      fprintf('|%5.1f |%5.1f |%5.1f |\n',y(i,:))
   end

   fprintf('\n');
   y = lin_to_fp(res);
   fprintf('%s\n',['Fit without r residuals:'])
   for i=1:3
      fprintf('|%5.1f |%5.1f |%5.1f |\n',y(i,:))
   end

% Fitted offsets (with r)
   fprintf('\n');
   fprintf('%s %8.1f%8.1f%8.1f\n','x withr:    ',x_r)

% Uncertainties
   ce_r = (ci_r(:,2) - ci_r(:,1))/2;
   fprintf('%s %8.1f%8.1f%8.1f\n','U withr +-: ',ce_r)

% Fitted offsets (no r)
   fprintf('\n');
   fprintf('%s %8.1f%8.1f\n','x (no r):   ',x)

% Uncertainties
   ce = (ci(:,2) - ci(:,1))/2;
   fprintf('%s %8.1f%8.1f\n','U (no r) +-:',ce)

   fprintf('\n');
   fprintf('%s\n',['mean(abs(residuals)  With r, Without r'])
   rr = mean(abs(res_r));
   r = mean(abs(res));
   fprintf('%5.1f %5.1f \n',rr,r)

