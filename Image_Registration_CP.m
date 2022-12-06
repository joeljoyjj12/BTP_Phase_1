%----------------------------------------------------------------------%
%----------------------------- Part A ---------------------------------%
%----------------------------------------------------------------------%
%{
    Part A involves coarse registration of the 2 images taken.
    Uses cpselect to get the transform matrix and then transforms
    the moving image
%}
file1='Images/MRI21.jpg';
%file1='Images/HFR_2.png';
file1='Images/P1_sample.png';
file2='Images/MRI22.jpg';
%file2='Images/HFR_1.png';
file2='Images/P2_sample.png';
I1=rgb2gray(imread(file1));
I2=rgb2gray(imread(file2));

%%
fixed=I1;
moving=I2;

% Select control points
[mp,fp]=cpselect(moving,fixed,Wait=true);

% Infer Geometric transformation
%t = fitgeotform2d(mp,fp,"projective");
%t = fitgeotform2d(mp,fp,"affine");
t = fitgeotform2d(mp,fp,"similarity");

%%
% Transform Unregistered image
Rfixed = imref2d(size(fixed));
registered = imwarp(moving,t,OutputView=Rfixed,FillValues=0);
%registered = imwarp(moving,t,FillValues=0);
%registered = imwarp(moving,t,FillValues=0);

%Show results
%imshowpair(fixed,registered,"blend");
imshowpair(fixed,registered,"falsecolor");

%%
figure();

subplot(1,3,1);
imagesc(moving);
colormap('gray');
%imshow(moving);
title('Unregistered');

subplot(1,3,2);
imagesc(registered);
colormap('gray');
%imshow(registered);
title('registered');

subplot(1,3,3);
imagesc(fixed);
colormap('gray');
%imshow(fixed);
title('Fixed Image');


%%
%----------------------------------------------------------------------%
%----------------------------- Part B ---------------------------------%
%----------------------------------------------------------------------%
%{
    Fine registration using DWT decomposition
%}

I2_reg=registered;

[LL1_reg,LH1_reg,LV1_reg,LD1_reg] = dwt2(I2_reg,'haar');
%plot_wavelet(LL1_reg,LH1_reg,LV1_reg,LD1_reg);
[LL2_reg,LH2_reg,LV2_reg,LD2_reg] = dwt2(LL1_reg,'haar');
%plot_wavelet(LL2_reg,LH2_reg,LV2_reg,LD2_reg);

%%
[LL1_f,LH1_f,LV1_f,LD1_f] = dwt2(I1,'haar');
%plot_wavelet(LL1_f,LH1_f,LV1_f,LD1_f);
[LL2_f,LH2_f,LV2_f,LD2_f] = dwt2(LL1_f,'haar');
%plot_wavelet(LL2_f,LH2_f,LV2_f,LD2_f);

%%

% Regional Energy E(x,y)
w=1/16*[1 2 1;2 4 2;1 2 1];
I_reg=LD1_reg;
I_f=LD1_f;
Q_reg=I_reg.^2;
Q_f=I_f.^2;

E_reg=conv2(Q_reg,w,'same');
E_f=conv2(Q_f,w,'same');

% Similarity
P=LD1_reg.*LD1_f;
S=2*conv2(P,w,'same');
S=S./(E_reg+E_f);

S(isnan(S))=1;

% Fused subband
T=0.65; % Threshold

%%
[m,n]=size(S);
I_fused=zeros(m,n);

W_min=(S-T)/(2*(1-T));
W_max=1-W_min;
%%
c1=(S<=T)&(E_reg>E_f);
c2=(S<=T)&(E_reg<=E_f);
c3=(S>T)&(E_reg>E_f);
c4=(S>T)&(E_reg<=E_f);

I_fused(c1)=I_reg(c1);
I_fused(c2)=I_f(c2);
I_fused(c3)=I_reg(c3);
I_fused(c4)=I_f(c4);

%{
for i=1:m
    for j=1:n
        if(S(i,j)<=T)
            if(E_reg(i,j)>E_f(i,j))
                I_fused(i,j)=I_reg(i,j);
            else
                I_fused(i,j)=I_f(i,j);
            end
        else
            if(E_reg(i,j)>E_f(i,j))
                I_fused(i,j)=W_max(i,j)*I_reg(i,j)+W_min(i,j)*I_f(i,j);
            else
                I_fused(i,j)=W_min(i,j)*I_reg(i,j)+W_max(i,j)*I_f(i,j);
            end
        end
    end
end
%}

%%
% Show fused DWT
figure();
imagesc(I_fused);
colormap('gray');
title('Fused');

figure();
imagesc(I_f);
colormap('gray');
title('Fixed');

figure();
imagesc(I_reg);
colormap('gray');
title('Registered');

