function [Lout,labout,blocksizeout,strout]=Fun_refreshlabels(L,blocksize,str)
%% LABORATORIUM PRZETWARZANIA OBRAZ�W
%% Pawe� Badura 2009
%% 
%% Funkcja przenumerowuj�ca etykiety w macierzy L wg. malej�cych rozmiar�w obszar�w

[blocksizeout,indmaxreg]=sort(nonzeros(blocksize),'descend');  % usu� bloki nieistniej�ce, posortuj pozosta�e
labout=unique(L);
Lout=zeros(size(L));
for i=1:size(labout,1)
    Lout(L==labout(indmaxreg(i)))=i;
    strout(i)=str(labout(indmaxreg(i)));
end
labout=[1:size(labout,1)]';