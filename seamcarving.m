clc; clear; close all;

percentage = 0.3;

name = 'Snowman';
orgimg = imread(['..\data\Samples dataset\' name '\' name '.png']);
orgmap = imread(['../data/Samples dataset\' name '\' name '_SMap.png']);
img = orgimg;
emap = orgmap;
seamgraph = zeros(size(img,1),size(img,2));
seamgraph(1,:) = emap(1,:); 

diff = size(img,2)*percentage;

for l=1:diff
for i=2:size(img,1)
    for j=1:size(img,2)
        if j==1
            seamgraph(i,j)=double(emap(i,j)) + min([seamgraph(i-1,j) seamgraph(i-1,j+1)]);
        elseif j==size(img,2)
            seamgraph(i,j)=double(emap(i,j)) + min([seamgraph(i-1,j-1) seamgraph(i-1,j)]);
        else
            seamgraph(i,j)=double(emap(i,j)) + min([seamgraph(i-1,j-1) seamgraph(i-1,j) seamgraph(i-1,j+1)]);
        end
    end
end
seam = uint8(zeros(size(img,1),1));
minen = min(seamgraph(size(img,1),:));
for i=1:size(img,2)
    if seamgraph(size(img,1),i)==minen
        seam(size(img,1)) = i;
        break;
    end
end
for i=size(img,1)-1:1
    seam(i+1)=x;
    if x==1
        if seamgraph(i,1) > seamgraph(i,2)
            seam(i)=2;
        else
            seam(i)=1;
        end
    elseif x==size(img,2)
        if seamgraph(i,size(img,2)) > seamgraph(i,size(img,2)-1)
            seam(i)=size(img,2)-1;
        else
            seam(i)=size(img,2);
        end
    else
        if seamgraph(i,x)<seamgraph(i,x-1) && seamgraph(i,x)<seamgraph(i,x+1)
            seam(i)=x;
        elseif seamgraph(i,x-1)<seamgraph(i,x-2)
            seam(i)=x-1;
        else
            seam(i)=x+1;
        end
    end
end

imghat = zeros(size(img,1),size(img,2)-1,3);
emaphat = zeros(size(emap,1),size(emap,2)-1);
sghat = zeros(size(seamgraph,1),size(seamgraph,2)-1);
for i=size(img,1):1
    t = [1:seam(i)-1, seam(i)+1:size(img,2)];
    imghat(i,:,:) = img(i,t,:);
    emaphat(i,:,:) = emap(i,t,:);
    sghat(i,:,:) = seamgraph(i,t,:);
% 	imghat(i,1:seam(i)-1,:) = img(i,1:seam(i)-1);
%     imghat(i,seam(i):size(imghat,2),:) = img(i,seam(i)+1:size(img,2));
%     emaphat(i,1:seam(i)-1) = emap(i,1:seam(i)-1);
%     emaphat(i,seam(i):size(imghat,2)) = emap(i,seam(i)+1:size(emap,2));
%     sghat(i,1:seam(i)-1) = seamgraph(i,1:seam(i)-1);
%     sghat(i,seam(i):size(imghat,2)) = seamgraph(i,seam(i)+1:size(seamgraph,2));
end
img = imghat;
emap = emaphat;
seamgraph = sghat;
end
imshow(img);
