%% ELEN E4810 HW 5, Q2 - Lossy image compression
%   NOTE: Except for the TO-DO section, there is no need to edit the other 
%   sections of the code.
clear; clc;
figure(101); clf;
load('DCTQ.mat');

%% Read patches from image - see 'help image2patches':
[pats_in, patwh, im_array] = image2patches('lena.bmp');
imsz = size(im_array);  npx = prod(imsz);

%% Process each patch:
avgenergy = zeros(8);               % keep track of the average DCT energy
nzeros = zeros(8);                  % count the number of nzeros

npatsin = numel(pats_in);
pats_rec = cell(npatsin,1);
for i = 1:npatsin
%% TO-DO: Process each patch in this loop!
    ls = 20;
    s = zeros(ls,1);
    flag = 0;
    %% step 1                            
    pats_rec{i} = dct2(pats_in{i}-128);     
    for a = 1:64
        %% step 2
        avgenergy(a) = avgenergy(a)+(pats_rec{i}(a))^2/npatsin; 
        %% step 3
        pats_rec{i}(a) = round(pats_rec{i}(a)/Q(a));
        %% step 4
        if pats_rec{i}(a) ~= 0
             nzeros(a) = nzeros(a)+1;  
            %% optional
%             for j = 1:ls
%                 if abs(pats_rec{i}(a)) > s(j)
%                     flag = 1;
%                 end           
%             end 
         end
        %% optional
%         if flag == 1
%             temp = 1;
%             s_temp = s(temp);
%             for k = 1:ls
%                 if s(k) < s_temp
%                  	s_temp = s(k);
%                  	temp = k;
%                 end
%             end
%             s(temp) = abs(pats_rec{i}(a)); 
%             flag = 0;
%         end
        %% step 5
         pats_rec{i}(a) = pats_rec{i}(a)*Q(a);
    end 
    %% optional
%     for b = 1:64
%         for c = 1:ls
%             if abs(pats_rec{i}(b)) ~= s(c)
%                 pats_rec{i}(b) = 0;
%             end
%         end
%         if pats_rec{i}(b) ~= 0
%             nzeros(b) = nzeros(b)+1; 
%         end
%         pats_rec{i}(b) = pats_rec{i}(b)*Q(b);
%     end
    pats_rec{i} = idct2(pats_rec{i});
end    
%% Reconstruct image from patches and show results:
im_rec = cell2mat(reshape(pats_rec, patwh));
im_diff = im_array-im_rec;
fprintf(['Original size: %dx%d = %d px.\nNonzeros after quantization: %d.' ...
    '\nCompression ratio: %.2e. \nRMSE: %.2e.    Mean abs. dev.: %.2e\n\n'], ...
    imsz(1), imsz(2), npx, sum(nzeros(:)), npx/sum(nzeros(:)), ...
    norm(im_diff(:))/sqrt(npx), norm(im_diff,1)/npx);

figure(101);
subplot(221); imagesc(im_array, [0 255]); colormap('gray');
title('Original image');
subplot(222); imagesc(im_rec, [0 255]); colormap('gray');
title('Reconstructed image');
subplot(223); imagesc(log(avgenergy)); colormap('gray');
title('log average DCT energies on patches'); colorbar;
subplot(224); imagesc(log(nzeros/npatsin)); colormap('gray');
title('log frequency of nzeros on DCT after quantization'); colorbar;