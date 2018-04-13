    clear;
    clc;
    close all;
    for i=1:10
        I  = rgb2gray(imread(['1 (',num2str(i),').jpg']));
        thresh = graythresh(I);     %�Զ�ȷ����ֵ����ֵ
        bw_img = im2bw(I,thresh*0.6);       %��ͼ���ֵ��
        
%         figure(1);
%         imshow(bw_img);
        %��������ѡȡǰ20���������
        I20=findlargest_20_block(bw_img,20);
        
        bw_img=bw_img-I20;
        bw_img = im2bw(bw_img,0);       %��ͼ���ֵ��
        
%         figure(2);
%         imshow(bw_img);
        
        
        
        %�������������ǡ�������
        %������ȡ��ͨ����
%         [L, num] = bwlabel(I2, 8);
%         status = regionprops(L,'Area', 'Perimeter');
%         area = [status.Area];  %ÿ�������е����ش�С
        
        %������ʾ������ͨ����
        img_reg = regionprops(bw_img,  'area', 'boundingbox');  
        areas = [img_reg.Area];  
        rects = cat(1,  img_reg.BoundingBox);
        
        %������ʾ��������ķ��򡪡�
%         figure(1);
%         imshow(bw_img);  
%         for i = 1:size(rects, 1)  
%             rectangle('position', rects(i, :), 'EdgeColor', 'r');  
%         end  
        
        [~, max_id] = max(areas);  
        max_rect = rects(max_id, :);  

        % show the largest connected region  
%         figure(2);   
%         imshow(bw_img);  
%         rectangle('position', max_rect, 'EdgeColor', 'r');  
        
        %������ȡ��ͼ�񡪡�����
        Img=regionprops(bw_img, 'Image');  
        %x=regionprops(bw_img, 'PixelIdxList');  
        YX=regionprops(bw_img, 'PixelList');  
        
        for i1=1:size(Img,1)
            subImg=Img(i1).Image;
            %imshow(subImg); 
            
            [w,h]=size(subImg);
            
            if w>20||h>20
                XY=YX(i1).PixelList;
                
                sumx=sum(subImg,1);
                sumy=sum(subImg,2);

                xmax=max(sumx);
                ymax=max(sumy);
                
                xmin=min(sumx);
                ymin=min(sumy);
                
                rx=xmax/w;
                ry=ymax/h;
                
                rx1=xmax/xmin;
                ry1=ymax/ymin;
                if rx>0.5||ry>0.5%||ry1>10||rx1>10
                    for i2=1:size(XY)
                        bw_img(XY(i2,2),XY(i2,1))=0;
                    end
                end
            end
            
            
%             max_rect = rects(i, :);%ǰ����ֵΪ���ϵ�����꣬������ֵΪ����Ĵ�С
%             figure(2);   
%             imshow(bw_img);  
%             hold on;
%             rectangle('position', max_rect, 'EdgeColor', 'r');  
            
            
            
            %figure(3);  
            %imshow(subImg); 
            
        end
        %imshow(bw_img);
        
        imwrite(bw_img, [num2str(i),'.jpg']); 
        
    end
    
    
%     I2=double(I2);
%     [w,h]=size(I2);
    
    
    
%     [L, num] = bwlabel(I2, 8);     
%     status = regionprops(L,'Area', 'Perimeter');
%     area = [status.Area];
    
    
    
%     markarea=zeros(w,h);
%     %����������ÿ��������Χ��8�����Ƿ�������ֵ�������;
%     n=1;
%     for i=2:w-2
%         for j=2:h-2
%             l=[];
% %             Imark1=markarea;
%             mask=zeros(w,h);
%             if I2(i,j)>0&&markarea(i,j)==0;%ȷ�������û�б�����������������ֵ
%                 markarea(i,j)=1;%��ǰ�����Ҫ����¼�£������ظ�����
%                 l(1,:)=Calcul_around(i,j,I2);%�ӵ�һ���㿪ʼ��l��¼����Χ�ĵ��Ƿ������أ�8�������еĻ���Ϊ1,,
%                 
%                 n=1;
%                 r(n,:)=[i j];
%                 while(size(l,1)>0)
%                    
%                    %ÿ��ѭ�����Ȳ鿴��һ�У����µĵ����Ϣ��ӵ����һ��
%                    if l(1,1)>0&&markarea(l(1,9)-1,l(1,10)-1)==0  %���Ͻ�    ������ֵ����δ����������ʱ��
%                        l(1,1)=0;                                 %        
%                        l(size(l,1)+1,:)=Calcul_around(l(1,9)-1,l(1,10)-1,I2);
%                        l(size(l,1),8)=0;
%                        markarea(l(1,9)-1,l(1,10)-1)=1;
%                    end
%                    if l(1,2)>0&&markarea(l(1,9)-1,l(1,10))==0  %��
%                        l(1,2)=0; 
%                        l(size(l,1)+1,:)=Calcul_around(l(1,9)-1,l(1,10),I2);
%                        l(size(l,1),7)=0;
%                        markarea(l(1,9)-1,l(1,10))=1;
%                    end
%                    if l(1,3)>0&&markarea(l(1,9)-1,l(1,10)+1)==0  %����
%                        l(1,3)=0; 
%                        l(size(l,1)+1,:)=Calcul_around(l(1,9)-1,l(1,10)+1,I2);
%                        l(size(l,1),6)=0;
%                        markarea(l(1,9)-1,l(1,10)+1)=1;
%                    end
%                    if l(1,4)>0&&markarea(l(1,9),l(1,10)-1)==0  %��
%                        l(1,4)=0; 
%                        l(size(l,1)+1,:)=Calcul_around(l(1,9),l(1,10)-1,I2);
%                        l(size(l,1),5)=0;
%                        markarea(l(1,9),l(1,10)-1)=1;
%                    end
%                    if l(1,5)>0&&markarea(l(1,9),l(1,10)+1)==0  %��
%                        l(1,5)=0; 
%                        l(size(l,1)+1,:)=Calcul_around(l(1,9),l(1,10)+1,I2);
%                        l(size(l,1),4)=0;
%                        markarea(l(1,9),l(1,10)+1)=1;
%                    end
%                    if l(1,6)>0&&markarea(l(1,9)+1,l(1,10)-1)==0  %����
%                        l(1,6)=0; 
%                        l(size(l,1)+1,:)=Calcul_around(l(1,9)+1,l(1,10)-1,I2);
%                        l(size(l,1),3)=0;
%                        markarea(l(1,9)+1,l(1,10)-1)=1;
%                    end
%                    if l(1,7)>0&&markarea(l(1,9)+1,l(1,10))==0  %��
%                        l(1,7)=0; 
%                        l(size(l,1)+1,:)=Calcul_around(l(1,9)+1,l(1,10),I2);
%                        l(size(l,1),2)=0;
%                        markarea(l(1,9)+1,l(1,10))=1;
%                    end
%                    if l(1,8)>0&&markarea(l(1,9)+1,l(1,10)+1)==0  %����
%                        l(1,8)=0; 
%                        l(size(l,1)+1,:)=Calcul_around(l(1,9)+1,l(1,10)+1,I2);
%                        l(size(l,1),1)=0;
%                        markarea(l(1,9)+1,l(1,10)+1)=1;
%                    end
%                    %l(1:1-1,:)=l(1:1-1,:);
%                    if size(l,1)==1;
%                        r(n,:)=[l(9) l(10)];
%                        n=n+1;
%                        l=[];
%                        
%                    else
%                        r(n,:)=[l(size(l,1),9) l(size(l,1),10)];%ÿ��ɾһ�����ʱ�򣬰�������¼����
%                        n=n+1;
%                        l(1:size(l,1)-1,:)=l(2:size(l,1),:);
%                        l(size(l,1),:)=[];
%                        
%                    end
%                    for i2=1:size(r,1)
%                         mask(r(i2,1),r(i2,2))=255;
%                    end
%                    figure(2);
%                    imshow(mask);
%                 end
% %                 minrx=min(r(:,1))-1;
% %                 minry=min(r(:,2))-1;
% %                 
% %                 r(:,1)=r(:,1)-minrx;
% %                 r(:,2)=r(:,2)-minry;
% %                 
% %                 maxr=max(max(r));
% %                 mask=zeros(maxr,maxr);
%                 
%                 
%                 
%             end
% %             Ires=markarea-Imark1;
% %             if sum(Ires)>0
% %                 imshow(Ires);
% %             end
%         end
%     end
% 
%     
%     markarea = im2bw(markarea,0);       %��ͼ���ֵ��
%     figure(2);
%     imshow(markarea);