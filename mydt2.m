function [ DT2_X ] = mydt2( X, D )

DT2_X = transpose(D*transpose(D*X));
% If you want 2-d dct with X not a square matrix but an m by n matrix, 
% then the first D inside should be m by m dctmtx
% and the second D outside should be n by n dctmtx

end

