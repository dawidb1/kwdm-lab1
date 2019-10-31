function [Lout,labout,blocksizeout,strout]=Fun_refreshlabels(L,blocksize,str)
%% LABORATORIUM PRZETWARZANIA OBRAZÓW
%% Pawe³ Badura 2009
%% 
%% Funkcja przenumerowuj¹ca etykiety w macierzy L wg. malej¹cych rozmiarów obszarów

[blocksizeout,indmaxreg]=sort(nonzeros(blocksize),'descend');  % usuñ bloki nieistniej¹ce, posortuj pozosta³e
labout=unique(L);
Lout=zeros(size(L));
for i=1:size(labout,1)
    Lout(L==labout(indmaxreg(i)))=i;
    strout(i)=str(labout(indmaxreg(i)));
end
labout=[1:size(labout,1)]';