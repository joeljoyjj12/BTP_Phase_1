P1_=importdata('dataset_P1_sample_connector_PwSa7.6MHz_23_Nov_2022/dataset_PW1_23_Nov_2022_ 3_20_34_PM.mat');
P1=P1_.ImgData;

%log_im=log(P1(:,:,3));
n=length(P1(1,1,:));
for i=1:n
    US_im=US_image(P1(:,:,i));
    figure(2);
    imagesc(US_im);
    colormap('gray');
    title(i)
    pause(0.2);
end

figure();
im1=imread('dataset_P1_sample_connector_PwSa7.6MHz_23_Nov_2022\img_p1_connector.jpg');
imshow(im1);

%%
P2=importdata('dataset_P2_sample_connector_PwSa7.6MHz_23_Nov_2022\dataset_PW1_23_Nov_2022_ 3_25_49_PM.mat');
P2=P2.ImgData;

%log_im=log(P1(:,:,3));
n=length(P2(1,1,:));
for i=1:n
    US_im=US_image(P2(:,:,i));
    figure(8);
    imagesc(US_im);
    colormap('gray');
    title(i)
    pause(0.1);
end

figure();
im2=imread('dataset_P2_sample_connector_PwSa7.6MHz_23_Nov_2022\img_P2_connector.jpg');
imshow(im2);

%%
imshow(im1(40:574,44:580,3));
imsave;