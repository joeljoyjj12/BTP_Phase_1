%file_name='Dataset_Connector\28_11_2022\dataset_P1_sample_connector_PwSa7.6MHz_28_Nov_2022\dataset_PW1_28_Nov_2022_12_20_40_PM.mat';
%file_name='Dataset_Connector\28_11_2022\dataset_P2_sample_connector_PwSa7.6MHz_28_Nov_2022\dataset_PW1_28_Nov_2022_12_09_25_PM.mat';
file_name='Dataset_Connector\28_11_2022\dataset_P1_multi_frame_connector_PwSa7.6MHz_28_Nov_2022\dataset_PW1_28_Nov_2022_12_37_43_PM.mat';

P1_=importdata(file_name);
P1=P1_.ImgData;

%log_im=log(P1(:,:,3));
n=length(P1(1,1,:));
for i=340:2:n
    US_im=US_image(P1(:,:,i));
    figure(2);
    imagesc(US_im);
    colormap('gray');
    title(i)
    pause(0.2);
end

%figure();
%im1=imread('Dataset_Connector\28_11_2022\dataset_P1_sample_connector_PwSa7.6MHz_28_Nov_2022\P1_sample.png');
%im1=imread('Dataset_Connector\28_11_2022\dataset_P2_sample_connector_PwSa7.6MHz_28_Nov_2022\P2_sample.png');
%imshow(im1);

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