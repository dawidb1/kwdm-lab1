function img = getImage(handles)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

m = handles.m;
n = handles.n;
file = handles.file;


I = double(file.s.serie{n,1}); 
img = I(:,:,m);

end

