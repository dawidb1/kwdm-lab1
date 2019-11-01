function [mask,imgNew] = segm_auto(img, axes)
    max_dJ_split=0.3;       % maksymalna ró¿nica intensywnoœci w bloku (faza podzia³u)
    max_dJ_merge=0.3;       % maksymalna ró¿nica œrednich intensywnoœci bloków (faza ³¹czenia)
    min_blok=1;             % minimalny rozmiar bloku
    
%     ---------------
img = pow2resize(img);

Jd=double(img);           % Jd - wersja double do obliczeñ
[w,k]=size(img);                              % w x k - rozmiary obrazu J
Jmin=min(min(img));   
Jmax=max(max(img));       % skrajne wartoœci intensywnoœci w J
% ---------------------

% Faza podzia³u

% [u,v]=size(img);
% minSize = min([u,v]);
    S=qtdecomp(img,max_dJ_split,min_blok);
% Faza ³¹czenia    
    L=Fun_qtmerge(img,S,max_dJ_merge*Jmax);
% Wyœwietlanie
%     TODO poprawienie wy?wietlania wyników
a=Fun_dispedges(img,find(Fun_unlabel(L)),Jmax);
x1=a(:,:,1);
XX1=logical(x1-img);

z = wljoin(img, logical(XX1), [0.5 1 0.5], 'be');

imshow(z,[],'Parent',axes);  
imgNew=img;
mask=XX1;
end

