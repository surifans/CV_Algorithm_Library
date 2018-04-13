    clear;
    clc;
    close all;
    for i=2%1:10
        I  = rgb2gray(imread(['1 (',num2str(i),').jpg']));
        thresh = graythresh(I);     %自动确定二值化阈值
        bw_img = im2bw(I,thresh*0.6);       %对图像二值化
        
%         figure(1);
%         imshow(bw_img);
        %————选取前20个最大区块
        I20=findlargest_20_block(bw_img,20);
        
        bw_img=bw_img-I20;
        bw_img = im2bw(bw_img,0);       %对图像二值化
        
%         figure(2);
%         imshow(bw_img);
        
        %imwrite(bw_img, [num2str(i),'.jpg']); 
        
        %————区域标记————
        %——获取联通区域
%         [L, num] = bwlabel(I2, 8);
%         status = regionprops(L,'Area', 'Perimeter');
%         area = [status.Area];  %每个区块中的像素大小
        
        %——显示所有联通区域
        img_reg = regionprops(bw_img,  'area', 'boundingbox');  
        areas = [img_reg.Area];  
        rects = cat(1,  img_reg.BoundingBox);
        
        %——显示所有区块的方框——
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
        
        %——获取子图像————
        Img=regionprops(bw_img, 'Image');  
        %x=regionprops(bw_img, 'PixelIdxList');  
        YX=regionprops(bw_img, 'PixelList');  
        
        for i1=1:size(Img,1)    %遍历每个图块
            subImg=Img(i1).Image;
            %imshow(subImg); 
            
            [w,h]=size(subImg);
            XY=YX(i1).PixelList;
            if w>20||h>20 %考虑图块比较大的情形下
                
                
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
            else   %考虑图块比较小的情形
                max_rect = rects(i1, :);%前两个值为左上点的坐标，后面两值为方框的大小
                wfloor=floor(max_rect(2));%行
                hfloor=floor(max_rect(1));%列
                
                N1=20;
                wtop=max(wfloor-N1,1);
                hleft=max(hfloor-N1,1);
                
                wdown=min(wfloor+max_rect(4)+N1,w);
                hright=min(hfloor+max_rect(3)+N1,h);
                
                increas1=double(bw_img(wtop:wdown,hleft:hfloor));
                increas2=double(bw_img(wtop:wdown,hfloor+max_rect(3):hright));
                increas3=double(bw_img(wtop:wfloor,hleft:hright));
                increas4=double(bw_img(wfloor+max_rect(4):wdown,hleft:hright));
                
                Increased=sum(sum(increas1))+sum(sum(increas2))+sum(sum(increas3))+sum(sum(increas4));
                
                if Increased==0;
                    for i2=1:size(XY)
                        bw_img(XY(i2,2),XY(i2,1))=0;
                    end
                end
            end
            
            

            
            
            %figure(3);  
            %imshow(subImg); 
            
        end
        %imshow(bw_img);
        imwrite(bw_img, [num2str(i),'2.jpg']); 
        
        
    end
 