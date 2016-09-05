%This procedure works for LBP

clear all;
close all;
clc;

img=imread('E:\毕业设计\lina.jpg');

figure(1);
imshow(img);

if length(size(img))==3
    [m, n, z]=size(img);
else
    [m, n] = size(img);
end

imgn=zeros(m,n);
for i=2:m-1
   for j=2:n-2 
        
       pow=0;
        for p=i-1:i+1
            for q =j-1:j+1
                if img(p,q) > img(i,j)
                    if p~=i || q~=j         %有的文章这里是3*3的顺时针编码，我就按处理顺序编码了。
                                            %反正都是特征描述啥的，只要按相同规则就行了。
                      imgn(i,j)=imgn(i,j)+2^pow;
                      pow=pow+1;
                    end
                end
            end
        end
            
   end
end
figure(2);
imshow(imgn,[]);

hist=cell(1,100);     %划分四个区域求直方图，10*10的太多了，这里搞简单点
% hist{1}=imhist(img(1:floor(m/2),1:floor(n/2)));
% hist{2}=imhist(img(1:floor(m/2),floor(n/2)+1:n));
% hist{3}=imhist(img(floor(m/2)+1:m,1:floor(n/2)));
% hist{4}=imhist(img(floor(m/2)+1:m,floor(n/2)+1:n));
% for i=1:4
%    figure;
%    plot(hist{i});
% end
flag1=0;flag2=0;
for i=1:10
    flag2=0;
    for j=1:10
    hist{(i-1)*10+j}=imhist(img(flag1+1:floor(m/10)+flag1,flag2+1:floor(n/10)+flag2));
    
    flag2=flag2+floor(n/10);
    end
    flag1=flag1+floor(m/10);
end

LBPfeature=hist{1};
for i=2:100
    LBPfeature=[LBPfeature,hist{i}];
end

%特征降维PCA

[COEFF,SCORE,latent]=princomp(LBPfeature');

ratio=cumsum(latent)./sum(latent);