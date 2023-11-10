function fo = fit_ppm(name,ppm,band,srf_name)

ppm = ppm';

fp = get_fp(band,srf_name);
fp_init = fp;

global ifl
ifl = 1:9;

bd = [1E6 1E6 1E6 1E6];
options = optimoptions('lsqcurvefit','Display','none');

[x_r,resnorm_r,res_r,eflag,out,lambda,Jacr] = lsqcurvefit(@fp_fit_withr2,[0 0 0 ],fp_init,ppm(ifl),-bd(1:3),bd(1:3),options);
ci_r = nlparci(x_r,res_r,'jacobian',Jacr);

[x,resnorm,res,eflag,out,lambda,Jac] = lsqcurvefit(@fp_fit,[0 0],fp_init,ppm(ifl),-bd(1:2),bd(1:2),options);
ci = nlparci(x,res,'jacobian',Jac);

fprintf('\n');
fprintf('%s \n','--------------------------------------------------------------');
fprintf('%s\n',name)

fo.ppm = ppm';
fo.x = x';
fo.x_r = x_r';
fo.ci = ci';
fo.ci_r = ci_r';
fo.res = res';
fo.res_r = res_r';
fo.name = name;

fit_print(ppm,x,x_r,ci,ci_r,res,res_r)

