Im=imread('P1_cropped.png');
imshow(Im);

[cA,cH,cV,cD] = dwt2(Im,'haar');

subplot(2,2,1);
imagesc(cA);
colormap('gray');

subplot(2,2,2);
imagesc(cH);
colormap('gray');

subplot(2,2,3);
imagesc(cV);
colormap('gray');

subplot(2,2,4);
imagesc(cD);
colormap('gray');

%%
I_P1=imread('P1_cropped.png');
I_P2=imread('P2_cropped.png');

I_P2_rot=imrotate(I_P2,-90);

subplot(1,2,1);
imshow(I_P1);
colormap('gray');

subplot(1,2,2);
imshow(I_P2_rot);
colormap('gray');

%%
%----------------- Image Registration ------------------
[optimizer,metric] = imregconfig("multimodal");
optimizer.InitialRadius = 0.0013;
optimizer.Epsilon = 1.5e-4;
optimizer.GrowthFactor = 1.05;
optimizer.MaximumIterations = 200;

[movingRegistered,R_reg] = imregister(I_P2_rot,I_P1,"affine",optimizer,metric);

%%
%imshowpair(I_P1,movingRegistered,"Scaling","joint")
figure();
imshow(I_P2_rot);
figure();
imshow(movingRegistered);