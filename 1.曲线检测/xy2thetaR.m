    clear;
    clc;
    close all;
    
    I  = rgb2gray(imread('test.jpg'));
    [w,h]=size(I);
    %——————将图像都缩放到高500——————
    a=ceil(500*double(h)/double(w));
    I=imresize(I,[500 ceil(double(a))]);
    [w,h,~]=size(I);
    
    n=1;
    for i=1:w
        for j=1:h
            if I(i,j)>0
                [theta(n),R(n)] = cart2pol(i,j);
                n=n+1;
            end
            
            
        end
    end
    figure(1);
    imshow(I);
    figure(2);
    plot(theta,R,'r.');
    
    figure(3);
    plot(R,theta,'r.');