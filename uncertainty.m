%   uncertainty.m
fs = 1000;
ts = 1/fs;
t = 0:ts:2;
lt = length(t);
x1 = zeros(lt,1);
for i = 1:lt
    if t(i) <=1
        x1(i) = cos(2*pi*250*t(i));
    else
        x1(i) = sin(2*pi*250*t(i));
    end
end
x1 = x1';
x2 = chirp(t,0,1,100,'Quadratic');

% plot STFT for x1
scrsz = get(groot,'ScreenSize');
figure('Position',[1 scrsz(4)/2-scrsz(4)/4 scrsz(3)/2 scrsz(4)/2])
subplot(2,2,1);
spectrogram(x1,128,0,512,1000)
title('Pure tone - 128 pt window - No overlap')

subplot(2,2,2);
spectrogram(x1,128,120,512,1000)
title('Pure tone - 128 pt window - 120 pt overlap')

subplot(2,2,3);
spectrogram(x1,512,0,512,1000)
title('Pure tone - 512 pt window - 0 pt overlap')

subplot(2,2,4);
spectrogram(x1,512,500,512,1000)
title('Pure tone - 512 pt window - 500 pt overlap')

% plot STFT for x2
scrsz = get(groot,'ScreenSize');
figure('Position',[scrsz(3)/2 scrsz(4)/2-scrsz(4)/4 scrsz(3)/2 scrsz(4)/2])
subplot(2,2,1);
spectrogram(x2,128,0,512,1000)
title('Quadratic chirp - 128 pt window - No overlap')

subplot(2,2,2);
spectrogram(x2,128,120,512,1000)
title('Quadratic chirp - 128 pt window - 120 pt overlap')

subplot(2,2,3);
spectrogram(x2,512,0,512,1000)
title('Quadratic chirp - 512 pt window - 0 pt overlap')

subplot(2,2,4);
spectrogram(x2,512,500,512,1000)
title('Quadratic chirp - 512 pt window - 500 pt overlap')