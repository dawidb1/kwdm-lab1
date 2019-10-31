function [nblocks]=Fun_nblocks(L,lab)
%% LABORATORIUM PRZETWARZANIA OBRAZ�W
%% Pawe� Badura 2009
%% 
%% Funkcja zwracaj�ca list� s�siad�w bloku lab w macierzy L

[w,k]=size(L);
maska=false(size(L));   maska(L==lab)=true;
maska=[ false(1,k+2);
        false(w,1)  maska   false(w,1);
        false(1,k+2)];
maska=bwperim(~maska);
maska=maska(2:w+1,2:k+1);
perim=nonzeros(maska.*L);
nblocks=unique(perim);