function [mask,imgNew] = segm_auto(img, axes)
    max_dJ_split=0.3;       % maksymalna r�nica intensywno�ci w bloku (faza podzia�u)
    max_dJ_merge=0.3;       % maksymalna r�nica �rednich intensywno�ci blok�w (faza ��czenia)
    min_blok=1;             % minimalny rozmiar bloku
    
%     ---------------
img = pow2resize(img);

Jd=double(img);           % Jd - wersja double do oblicze�
[w,k]=size(img);                              % w x k - rozmiary obrazu J
Jmin=min(min(img));   
Jmax=max(max(img));       % skrajne warto�ci intensywno�ci w J
% ---------------------

% Faza podzia�u

% [u,v]=size(img);
% minSize = min([u,v]);
    S=qtdecomp(img,max_dJ_split,min_blok);
% Faza ��czenia    
    L=Fun_qtmerge(img,S,max_dJ_merge*Jmax);
% Wy�wietlanie
%     TODO poprawienie wy?wietlania wynik�w
a=Fun_dispedges(img,find(Fun_unlabel(L)),Jmax);
x1=a(:,:,1);
XX1=logical(x1-img);

z = wljoin(img, logical(XX1), [0.5 1 0.5], 'be');

imshow(z,[],'Parent',axes);  
imgNew=img;
mask=XX1;
end

