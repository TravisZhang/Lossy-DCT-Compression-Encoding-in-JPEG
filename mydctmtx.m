function [ D ] = mydctmtx( N )
%   creat A
ln = N;
A = zeros(4*ln,ln);
i = 2;
j = 1;
while i < 2*ln+1
    A(i,j) = 1;
    i = i+2;
    j = j+1;   
end
i = 2*ln+2;
j = ln;
while i < 4*ln+1
    A(i,j) = 1;
    i = i+2;
    j = j-1;
end
%   creat B
B = zeros(ln,4*ln);
for k = 1:ln
    j = 0;
    for i = 1:4*ln
        B(k,i) = 0.5*exp(complex(0,-pi*2*j*(k-1)/(4*ln)));
        j = j+1;
    end
end
%   creat W
w = zeros(1,ln);
for i = 1:ln
    w(i)= sqrt(2/ln);
end
w(1) = sqrt(1/ln);
W = diag(w);
%   get D
D = real(W*B*A);
end

