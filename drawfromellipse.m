% clc
% close all

%%
load("/home/wu/codes/ELSDc/out_ellipse.txt");
img=imread("hockey.jpg");
% for i = 1:size(ellipse,1)
%     ellipse(i,:)
% end
[ysize,xsize,~]=size(img);
ellipse = out_ellipse(:,6:10);
% ellipse(:,2)=ysize-ellipse(:,2);
drawEllipses(ellipse',"hockey.jpg")