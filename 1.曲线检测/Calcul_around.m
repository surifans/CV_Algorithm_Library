%   计算给定的像素周围像素情况



function  mexforeverypix=Calcul_around(i,j,I)
    mexforeverypix(9)=i;
    mexforeverypix(10)=j;
    if I(i-1,j-1)>0
        mexforeverypix(1)=1;%左上角
    end
    if I(i-1,j)>0
        mexforeverypix(2)=1;%上
    end
    if I(i-1,j+1)>0         
        mexforeverypix(3)=1;%右上
    end
    if I(i,j-1)>0         
        mexforeverypix(4)=1;%左
    end
    if I(i,j+1)>0         
        mexforeverypix(5)=1;%右
    end
    if I(i+1,j-1)>0         
        mexforeverypix(6)=1;%左下
    end
    if I(i+1,j)>0         
        mexforeverypix(7)=1;%下
    end
    if I(i+1,j+1)>0         
        mexforeverypix(8)=1;%右下
    end
    

end