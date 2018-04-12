    clear;
    clc;
    close all;
    
    I  = rgb2gray(imread('2.jpg'));
    %——————将图像都缩放到高500——————
    [w,h]=size(I);
    a=ceil(500*double(h)/double(w));
    I=imresize(I,[500 ceil(double(a))]);
    
    thresh = graythresh(I);     %自动确定二值化阈值
    I2 = im2bw(I,0.03);       %对图像二值化
    imshow(I2);
    I2=double(I2);
    [w,h]=size(I2);
    
    
    
%     [L, num] = bwlabel(I2, 8);     
%     status = regionprops(L,'Area', 'Perimeter');
%     area = [status.Area];
    
    
    
    markarea=zeros(w,h);
    %————把每个像素周围的8个点是否有像素值存入表中;
    n=1;
    for i=11%5:w-5
        for j=213%5:h-5
            l=[];
            if I2(i,j)>0&&markarea(i,j)==0;
                markarea(i,j)=1;
                l(1,:)=Calcul_around(i,j,I2);
                while(size(l,1)>0)
                   N= size(l,1);
                   for i1=1%: N  %一直访问第一个
                       %清空这一行的l
                       if l(i1,1)>0&&markarea(l(i1,9)-1,l(i1,10)-1)==0  %左上角
                           l(i1,1)=0; 
                           l(size(l,1)+1,:)=Calcul_around(l(i1,9)-1,l(i1,10)-1,I2);
                           l(size(l,1),8)=0;
                           markarea(l(i1,9)-1,l(i1,10)-1)=1;
                       end
                       if l(i1,2)>0&&markarea(l(i1,9)-1,l(i1,10))==0  %上
                           l(i1,2)=0; 
                           l(size(l,1)+1,:)=Calcul_around(l(i1,9)-1,l(i1,10),I2);
                           l(size(l,1),7)=0;
                           markarea(l(i1,9)-1,l(i1,10))=1;
                       end
                       if l(i1,3)>0&&markarea(l(i1,9)-1,l(i1,10)+1)==0  %右上
                           l(i1,3)=0; 
                           l(size(l,1)+1,:)=Calcul_around(l(i1,9)-1,l(i1,10)+1,I2);
                           l(size(l,1),6)=0;
                           markarea(l(i1,9)-1,l(i1,10)+1)=1;
                       end
                       if l(i1,4)>0&&markarea(l(i1,9),l(i1,10)-1)==0  %左
                           l(i1,4)=0; 
                           l(size(l,1)+1,:)=Calcul_around(l(i1,9),l(i1,10)-1,I2);
                           l(size(l,1),5)=0;
                           markarea(l(i1,9),l(i1,10)-1)=1;
                       end
                       if l(i1,5)>0&&markarea(l(i1,9),l(i1,10)+1)==0  %右
                           l(i1,5)=0; 
                           l(size(l,1)+1,:)=Calcul_around(l(i1,9),l(i1,10)+1,I2);
                           l(size(l,1),4)=0;
                           markarea(l(i1,9),l(i1,10)+1)=1;
                       end
                       if l(i1,6)>0&&markarea(l(i1,9)+1,l(i1,10)-1)==0  %左下
                           l(i1,6)=0; 
                           l(size(l,1)+1,:)=Calcul_around(l(i1,9)+1,l(i1,10)-1,I2);
                           l(size(l,1),3)=0;
                           markarea(l(i1,9)+1,l(i1,10)-1)=1;
                       end
                       if l(i1,7)>0&&markarea(l(i1,9)+1,l(i1,10))==0  %下
                           l(i1,7)=0; 
                           l(size(l,1)+1,:)=Calcul_around(l(i1,9)+1,l(i1,10),I2);
                           l(size(l,1),2)=0;
                           markarea(l(i1,9)+1,l(i1,10))=1;
                       end
                       if l(i1,8)>0&&markarea(l(i1,9)+1,l(i1,10)+1)==0  %右下
                           l(i1,8)=0; 
                           l(size(l,1)+1,:)=Calcul_around(l(i1,9)+1,l(i1,10)+1,I2);
                           l(size(l,1),1)=0;
                           markarea(l(i1,9)+1,l(i1,10)+1)=1;
                       end
                       %l(1:i1-1,:)=l(1:i1-1,:);
                       l(i1:size(l,1)-1,:)=l(i1+1:size(l,1),:);
                       l(size(l,1),:)=[];
                   end
                end

            end
            
        end
    end
%    
% %————先筛选孤立的点——————
% for i=1:size(mexforeverypix,1)   
%     
%     
%     
% end







%     makearea=zeros(w,h);
%     for i=1:w
%         for j=1:h
%             if I2(i,j)>0
%                 
%             
%             
%             end
%             
%         end
%     end
%     
%     
%     