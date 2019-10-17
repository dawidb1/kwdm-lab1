pathData = 'DANE/SERIE';
names=dir('DANE/SERIE/*.mat');


for k=1:size(names)
file=load(fullfile(pathData,names(k,1).name));
end

n=size(file.s.serie,1);
I=file.s.serie{n,1};
m=2; %na razie przykladowa wartosc
img=I(:,:,m);
imshow(I(:,:,m),[]);
%Wyswietlanie ca³ej serii:
%showcl(I);
%maski
pathOut = 'DANE\WYNIKI';
namesOut = dir('DANE\WYNIKI\*.mat');
for k=1:size(namesOut)
fileOut=load(fullfile(pathOut,namesOut(k,1).name));
end
imgOut=double(file.s.serie{n,1}(:,:,m));
maska=double(fileOut.r.maska{1,1}(:,:,m));
z=wljoin(imgOut,maska,[0.5 1 0.5],'be');
figure; imshow(z);