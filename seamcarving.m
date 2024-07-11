clc; clear; close all;

percentage = 0.3;

orgimg = im2double(imread('../data/Samples dataset/Baby/Baby.png'));
salmap = im2double(imread('../data/Samples dataset/Baby/Baby_SMap.png'));
edgemap = edge(rgb2gray(orgimg));
img = orgimg;
emap = salmap;

seamgraph = zeros(size(img,1),size(img,2));
seamgraph(1,:) = emap(1,:); 

diff = size(img,2)*percentage;

for l=1:diff
for i=2:size(img,1)
    for j=1:size(img,2)
        if j==1 % if in first column
            seamgraph(i,j)=emap(i,j) + min([seamgraph(i-1,j) seamgraph(i-1,j+1)]); % corresponding
                % seamgraph value for current pixel is equal to emap value
                % + min(upper, upper-right) seamgraph value
        elseif j==size(img,2) % if in last column
            seamgraph(i,j)=emap(i,j) + min([seamgraph(i-1,j-1) seamgraph(i-1,j)]); % corresponding
                % seamgraph value for current pixel is equal to emap value
                % + min(upper, upper-left) seamgraph value
        else
            seamgraph(i,j)=emap(i,j) + min([seamgraph(i-1,j-1) seamgraph(i-1,j) seamgraph(i-1,j+1)]); % if anywhere
            % other than start and end, seamgraph value is equal to pixel
            % value + min(upper-left,upper,upper-right) seamgraph value
        end
    end
end
seam = uint8(zeros(size(img,1),1));
minen = min(seamgraph(size(img,1),:));
for i=1:size(img,2)
    if seamgraph(i,size(img,2))==minen
        seam(size(img,2)) = i;
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

imghat = zeros(size(img,1),size(img,2)-1);
emaphat = zeros(size(emap,1),size(emap,2)-1);
sghat = zeros(size(seamgraph,1),size(seamgraph,2)-1);
for i=1:size(img,1)
	imghat(i,1:seam(i)-1) = img(i,1:seam(i)-1);
    imghat(i,seam(i):size(imghat,2)) = img(i,seam(i)+1:size(img,2));
    emaphat(i,1:seam(i)-1) = emap(i,1:seam(i)-1);
    emaphat(i,seam(i):size(imghat,2)) = emap(i,seam(i)+1:size(emap,2));
    sghat(i,1:seam(i)-1) = seamgraph(i,1:seam(i)-1);
    sghat(i,seam(i):size(imghat,2)) = seamgraph(i,seam(i)+1:size(seamgraph,2));
end
img = imghat;
emap = emaphat;
seamgraph = sghat;
imshow(img);
end

