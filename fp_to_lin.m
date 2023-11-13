function [y] = fp_to_lin(x);

y = reshape(fliplr(x),1,9);

return
