    clear;
    clc;
    close all;
    
    img  = imread('test.jpg');
    figure(1)
    imshow(img);
    
    img_gray = rgb2gray(img);
    % the canny edge of image
    BW = edge(img_gray,'canny');
    figure(2);
    imshow(BW);
   
    % the theta and rho of transformed space
    [H,Theta,Rho] = hough(BW);
    
    figure(3);
    imshow(H,[],'XData',Theta,'YData',Rho,'InitialMagnification','fit'),title('rho\_theta space and peaks');
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal, hold on;
    
    
%     % label the top 5 intersections
%     P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
%     x = Theta(P(:,2)); 
%     y = Rho(P(:,1));
%     plot(x,y,'*','color','r');