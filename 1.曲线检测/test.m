    clear;
    clc;
    close all;
    
    I  = rgb2gray(imread('3.jpg'));
%     %��������������ͼ�����ŵ���500������������
%     [w,h]=size(I);
%     a=ceil(500*double(h)/double(w));
%     I=imresize(I,[500 ceil(double(a))]);
    
    %thresh = graythresh(I);     %�Զ�ȷ����ֵ����ֵ
    I2 = im2bw(I,0.5);       %��ͼ���ֵ��
    figure(1);
    imshow(I2);
    I2=double(I2);
    [w,h]=size(I2);
    
    
    
%     [L, num] = bwlabel(I2, 8);     
%     status = regionprops(L,'Area', 'Perimeter');
%     area = [status.Area];
    
    
    
    markarea=zeros(w,h);
    %����������ÿ��������Χ��8�����Ƿ�������ֵ�������;
    n=1;
    for i=2:w-2
        for j=2:h-2
            l=[];
%             Imark1=markarea;
            mask=zeros(w,h);
            if I2(i,j)>0&&markarea(i,j)==0;%ȷ�������û�б�����������������ֵ
                markarea(i,j)=1;%��ǰ�����Ҫ����¼�£������ظ�����
                l(1,:)=Calcul_around(i,j,I2);%�ӵ�һ���㿪ʼ��l��¼����Χ�ĵ��Ƿ������أ�8�������еĻ���Ϊ1,,
                
                n=1;
                r(n,:)=[i j];
                while(size(l,1)>0)
                   
                   %ÿ��ѭ�����Ȳ鿴��һ�У����µĵ����Ϣ��ӵ����һ��
                   if l(1,1)>0&&markarea(l(1,9)-1,l(1,10)-1)==0  %���Ͻ�    ������ֵ����δ����������ʱ��
                       l(1,1)=0;                                 %        
                       l(size(l,1)+1,:)=Calcul_around(l(1,9)-1,l(1,10)-1,I2);
                       l(size(l,1),8)=0;
                       markarea(l(1,9)-1,l(1,10)-1)=1;
                   end
                   if l(1,2)>0&&markarea(l(1,9)-1,l(1,10))==0  %��
                       l(1,2)=0; 
                       l(size(l,1)+1,:)=Calcul_around(l(1,9)-1,l(1,10),I2);
                       l(size(l,1),7)=0;
                       markarea(l(1,9)-1,l(1,10))=1;
                   end
                   if l(1,3)>0&&markarea(l(1,9)-1,l(1,10)+1)==0  %����
                       l(1,3)=0; 
                       l(size(l,1)+1,:)=Calcul_around(l(1,9)-1,l(1,10)+1,I2);
                       l(size(l,1),6)=0;
                       markarea(l(1,9)-1,l(1,10)+1)=1;
                   end
                   if l(1,4)>0&&markarea(l(1,9),l(1,10)-1)==0  %��
                       l(1,4)=0; 
                       l(size(l,1)+1,:)=Calcul_around(l(1,9),l(1,10)-1,I2);
                       l(size(l,1),5)=0;
                       markarea(l(1,9),l(1,10)-1)=1;
                   end
                   if l(1,5)>0&&markarea(l(1,9),l(1,10)+1)==0  %��
                       l(1,5)=0; 
                       l(size(l,1)+1,:)=Calcul_around(l(1,9),l(1,10)+1,I2);
                       l(size(l,1),4)=0;
                       markarea(l(1,9),l(1,10)+1)=1;
                   end
                   if l(1,6)>0&&markarea(l(1,9)+1,l(1,10)-1)==0  %����
                       l(1,6)=0; 
                       l(size(l,1)+1,:)=Calcul_around(l(1,9)+1,l(1,10)-1,I2);
                       l(size(l,1),3)=0;
                       markarea(l(1,9)+1,l(1,10)-1)=1;
                   end
                   if l(1,7)>0&&markarea(l(1,9)+1,l(1,10))==0  %��
                       l(1,7)=0; 
                       l(size(l,1)+1,:)=Calcul_around(l(1,9)+1,l(1,10),I2);
                       l(size(l,1),2)=0;
                       markarea(l(1,9)+1,l(1,10))=1;
                   end
                   if l(1,8)>0&&markarea(l(1,9)+1,l(1,10)+1)==0  %����
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
                       r(n,:)=[l(size(l,1),9) l(size(l,1),10)];%ÿ��ɾһ�����ʱ�򣬰�������¼����
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

    
    markarea = im2bw(markarea,0);       %��ͼ���ֵ��
    figure(2);
    imshow(markarea);