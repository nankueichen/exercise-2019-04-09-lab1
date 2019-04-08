%% load k-space data
disp("loading k-space data k1.mat");
load k1
whos k1

%% display k-space data for one of the 4 slices; one of the 8 receiver RF coils;
close all
kSpaceData = k1(:,:,3,8);
figure(1); mesh(abs(kSpaceData));
figure(2); imagesc(abs(kSpaceData)); colormap(gray); axis equal
figure(3); imagesc(abs(kSpaceData(1:80,1:80))); colormap(gray); axis equal
figure(4); imagesc(angle(kSpaceData)); colormap(gray); axis equal

%% fftshift
close all;
kSpaceData_fftshift = fftshift(kSpaceData);
figure(1); mesh(abs(kSpaceData_fftshift));
figure(2); imagesc(abs(kSpaceData_fftshift)); colormap(gray); axis equal
figure(3); imagesc(angle(kSpaceData_fftshift)); colormap(gray); axis equal

%% image reconstruction
close all
image1 = fft2(kSpaceData_fftshift);
whos image1
figure(1); imagesc(abs(image1)); colormap(gray); axis equal
figure(2); imagesc(angle(image1)); colormap(gray); axis equal

%% fftshift
close all
image1_fftshift = fftshift(image1);
figure(1); imagesc(abs(image1_fftshift)); colormap(gray); axis equal
figure(2); imagesc(angle(image1_fftshift)); colormap(gray); axis equal

%% suppressing high spatial frequency information
close all;
filter1 = hanning(192)*hanning(192)';
figure(1); imagesc(filter1); colormap(gray); axis equal
kSpaceData_filter1 = kSpaceData.*filter1;
image1_noFilter = fftshift(fft2(fftshift(kSpaceData)));
image1_filter1 = fftshift(fft2(fftshift(kSpaceData_filter1)));
figure(2); imagesc(abs(image1_noFilter)); colormap(gray); axis equal;
figure(3); imagesc(abs(image1_filter1)); colormap(gray); axis equal;
figure(4); imagesc(real(abs(image1_noFilter)-abs(image1_filter1))); colormap(gray); axis equal;

%% reconstructing the full k-space data
close all
imageFull = fftshift(fftshift(fft(fft(fftshift(fftshift(k1,1),2),[],1),[],2),1),2);
whos imageFull
figure(1); imagesc(abs(imageFull(:,:,3,8))); colormap(gray); axis equal;
figure(2); imagesc(abs(imageFull(:,:,1,8))); colormap(gray); axis equal;
figure(3); imagesc(abs(imageFull(:,:,3,4))); colormap(gray); axis equal;

%% 
close all;
imageMean4thDim = mean(imageFull,4);
whos imageMean4thDim 
figure(1); imagesc(abs(imageMean4thDim(:,:,3))); colormap(gray); axis equal;
figure(2); imagesc(abs(imageMean4thDim(:,:,1))); colormap(gray); axis equal;




