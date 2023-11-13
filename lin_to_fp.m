function [y] = lin_to_fp(x);

y = fliplr(reshape(x,3,3));

return
