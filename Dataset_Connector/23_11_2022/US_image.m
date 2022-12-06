function [image] = US_image(inp)
log_P=20*log10(inp./max(inp(:)));
%log_P=medfilt2(log_P);
%image=(log_P-min(log_P,[],'all'))/(max(log_P,[],'all')-min(log_P,[],'all'));
image=log_P;
%pout_imadjust = imadjust(image);
%pout_histeq = histeq(image);
%pout_adapthisteq = adapthisteq(image);
end

