%   ���������������Χ�������



function  mexforeverypix=Calcul_around(i,j,I)
    mexforeverypix(9)=i;
    mexforeverypix(10)=j;
    [w,h]=size(I);
    if i>2&&i<w&&j>2&&j<h
        if I(i-1,j-1)>0
            mexforeverypix(1)=1;%���Ͻ�
        end
        if I(i-1,j)>0
            mexforeverypix(2)=1;%��
        end
        if I(i-1,j+1)>0         
            mexforeverypix(3)=1;%����
        end
        if I(i,j-1)>0         
            mexforeverypix(4)=1;%��
        end
        if I(i,j+1)>0         
            mexforeverypix(5)=1;%��
        end
        if I(i+1,j-1)>0         
            mexforeverypix(6)=1;%����
        end
        if I(i+1,j)>0         
            mexforeverypix(7)=1;%��
        end
        if I(i+1,j+1)>0         
            mexforeverypix(8)=1;%����
        end
    else
        mexforeverypix(1:8)=0;
    end

end