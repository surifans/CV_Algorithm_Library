    clear;
    clc;
    close all;
    
    I  = rgb2gray(imread('3.jpg'));
%     %——————将图像都缩放到高500——————
%     [w,h]=size(I);
%     a=ceil(500*double(h)/double(w));
%     I=imresize(I,[500 ceil(double(a))]);
    
    %thresh = graythresh(I);     %自动确定二值化阈值
    I2 = im2bw(I,0.5);       %对图像二值化
    figure(1);
    imshow(I2);
    I2=double(I2);
    [w,h]=size(I2);
    
    
    
%     [L, num] = bwlabel(I2, 8);     
%     status = regionprops(L,'Area', 'Perimeter');
%     area = [status.Area];
    
    
    
    markarea=zeros(w,h);
    %————把每个像素周围的8个点是否有像素值存入表中;
    n=1;
    for i=2:w-2
        for j=2:h-2
            l=[];
%             Imark1=markarea;
            mask=zeros(w,h);
            if I2(i,j)>0&&markarea(i,j)==0;%确定这个点没有被遍历过，且有像素值
                markarea(i,j)=1;%当前这个点要被记录下，避免重复遍历
                l(1,:)=Calcul_around(i,j,I2);%从第一个点开始，l记录其周围的点是否有像素，8个方向，有的话记为1,,
                
                n=1;
                r(n,:)=[i j];
                while(size(l,1)>0)
                   
                   %每个循环中先查看第一行，把新的点的信息添加到最后一行
                   if l(1,1)>0&&markarea(l(1,9)-1,l(1,10)-1)==0  %左上角    有像素值，且未被遍历到的时候
                       l(1,1)=0;                                 %        
                       l(size(l,1)+1,:)=Calcul_around(l(1,9)-1,l(1,10)-1,I2);
                       l(size(l,1),8)=0;
                       markarea(l(1,9)-1,l(1,10)-1)=1;
                   end
                   if l(1,2)>0&&markarea(l(1,9)-1,l(1,10))==0  %上
                       l(1,2)=0; 
                       l(size(l,1)+1,:)=Calcul_around(l(1,9)-1,l(1,10),I2);
                       l(size(l,1),7)=0;
                       markarea(l(1,9)-1,l(1,10))=1;
                   end
                   if l(1,3)>0&&markarea(l(1,9)-1,l(1,10)+1)==0  %右上
                       l(1,3)=0; 
                       l(size(l,1)+1,:)=Calcul_around(l(1,9)-1,l(1,10)+1,I2);
                       l(size(l,1),6)=0;
                       markarea(l(1,9)-1,l(1,10)+1)=1;
                   end
                   if l(1,4)>0&&markarea(l(1,9),l(1,10)-1)==0  %左
                       l(1,4)=0; 
                       l(size(l,1)+1,:)=Calcul_around(l(1,9),l(1,10)-1,I2);
                       l(size(l,1),5)=0;
                       markarea(l(1,9),l(1,10)-1)=1;
                   end
                   if l(1,5)>0&&markarea(l(1,9),l(1,10)+1)==0  %右
                       l(1,5)=0; 
                       l(size(l,1)+1,:)=Calcul_around(l(1,9),l(1,10)+1,I2);
                       l(size(l,1),4)=0;
                       markarea(l(1,9),l(1,10)+1)=1;
                   end
                   if l(1,6)>0&&markarea(l(1,9)+1,l(1,10)-1)==0  %左下
                       l(1,6)=0; 
                       l(size(l,1)+1,:)=Calcul_around(l(1,9)+1,l(1,10)-1,I2);
                       l(size(l,1),3)=0;
                       markarea(l(1,9)+1,l(1,10)-1)=1;
                   end
                   if l(1,7)>0&&markarea(l(1,9)+1,l(1,10))==0  %下
                       l(1,7)=0; 
                       l(size(l,1)+1,:)=Calcul_around(l(1,9)+1,l(1,10),I2);
                       l(size(l,1),2)=0;
                       markarea(l(1,9)+1,l(1,10))=1;
                   end
                   if l(1,8)>0&&markarea(l(1,9)+1,l(1,10)+1)==0  %右下
                       l(1,8)=0; 
                       l(size(l,1)+1,:)=Calcul_around(l(1,9)+1,l(1,10)+1,I2);
                       l(size(l,1),1)=0;
                       markarea(l(1,9)+1,l(1,10)+1)=1;
                   end
                   %l(1:1-1,:)=l(1:1-1,:);
                   if size(l,1)==1;
                       r(n,:)=[l(9) l(10)];
                       n=n+1;
                       l=[];
                       
                   else
                       r(n,:)=[l(size(l,1),9) l(size(l,1),10)];%每次删一个点的时候，把这个点记录下来
                       n=n+1;
                       l(1:size(l,1)-1,:)=l(2:size(l,1),:);
                       l(size(l,1),:)=[];
                       
                   end
                   for i2=1:size(r,1)
                        mask(r(i2,1),r(i2,2))=255;
                   end
                   figure(2);
                   imshow(mask);
                end
%                 minrx=min(r(:,1))-1;
%                 minry=min(r(:,2))-1;
%                 
%                 r(:,1)=r(:,1)-minrx;
%                 r(:,2)=r(:,2)-minry;
%                 
%                 maxr=max(max(r));
%                 mask=zeros(maxr,maxr);
                
                
                
            end
%             Ires=markarea-Imark1;
%             if sum(Ires)>0
%                 imshow(Ires);
%             end
        end
    end

    
    markarea = im2bw(markarea,0);       %对图像二值化
    figure(2);
    imshow(markarea);