function  Iout=findlargest_20_block(Isobel,n)
        
        [L, num] = bwlabel(Isobel, 8);
        
        status = regionprops(L,'Area', 'Perimeter');
        area = [status.Area];
        
        
        [wm,hm]=size(Isobel);
        mask1=zeros(wm,hm);
        
        a=sort(area,'descend');
        
        if size(a,2)>=n
            %——————前5个最大块保存下来
            for i5=1:n
                clear index;
                index = find(area == a(i5));     
                sizeindex=size(index,2);
                for j1=1:sizeindex
                    [X,Y] = find(L==index(1,j1));
                    sizex=size(X);

                    for i1=1:sizex
                        mask1(X(i1),Y(i1))=1;
                    end
                end
            end
            
        else
            mask1=Isobel;
            
        end
        
        
        
        Iout=im2bw(mask1,0);



end