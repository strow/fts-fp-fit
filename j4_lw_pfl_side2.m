j4_pfl_side2_lw_ppm5 =   7.7;   %???? not sure yet

j4_pfl_side2_lw_fptype = [ ...
     -7.12     0.65     5.83  ; ...
     -8.42     0.00     4.53  ; ...
     -7.77     0.00     5.18  ];

j4_pfl_side2_lw = fp_to_lin(j4_pfl_side2_lw_fptype)';

j4_pfl_side2_lw_abs = j4_pfl_side2_lw + j4_pfl_side2_lw_ppm5;

%------------------------------ Neon --------------------
fprintf('\n');
fprintf('%s \n','-----------------------Neon------------------------------');
fprintf('%s \n','           LW      MW      SW');
fprintf('%s%8.1f%8.1\n','J4_Pfl_Side2: ',j4_pfl_side2_lw_ppm5);
i = 1;
fmw(i) = fit_ppm('j4_pfl_side2_lw_rel',j4_pfl_side2_lw,'LW','default');i = i + 1;

