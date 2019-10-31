function [L]=Fun_qtmerge(J,S,max_dJ)
%% LABORATORIUM PRZETWARZANIA OBRAZÓW
%% Pawe³ Badura 2009
%% 
%% Funkcja realizuj¹ca fazê ³¹czenia bloków

% Macierz etykiet bloków
L=zeros(size(S));                           % inicjalizacja macierzy L
str=struct('ind',{});                       % pomocnicza struktura do indeksów pikseli bloku
indS=find(S);                               % znajdŸ indeksy znaczników wszystkich bloków (rozmiar boku w lewym górnym rogu)
[iy,ix]=ind2sub(size(S),indS);              % przejdŸ na podwójne indeksy
[maxreg,indmaxreg]=sort(nonzeros(S),'descend'); % sorotwanie bloków malej¹co wg rozmiarów
for lab=1:size(iy,1)                        % etykietowanie bloków pocz¹wszy od najwiêkszych
    a=S(indS(indmaxreg(lab)));              % d³ugoœæ boku bloku lab
    L(iy(indmaxreg(lab)):iy(indmaxreg(lab))+a-1,ix(indmaxreg(lab)):ix(indmaxreg(lab))+a-1)=lab*ones(a);     % wype³nij ca³y blok etykiet¹ lab
    str(lab).ind=find(L==lab);              % indeksy punktów bloku
%     str(lab).M=max(J(str(lab).ind));        % maksymalna intensywnoœæ w bloku
%     str(lab).m=min(J(str(lab).ind));        % minimalna intensywnoœæ w bloku
    str(lab).avg=mean(J(str(lab).ind));     % œrednia intensywnoœæ w bloku
    blocksize(lab)=a*a;                     % liczba pikseli obiektu
end
labs0=0; labs1=unique(L);                   % labs1 - wektor z etykietami bloków
info=['  ===  FAZA PODZIALU  ==='];   disp(info);   % informacja
info=['Liczba blokow:  ',int2str(size(labs1,1))];   disp(info);     disp(' ');   % informacja
info=['  ===  FAZA LACZENIA  ==='];   disp(info);   % informacja
itcnt=0;
while (size(labs0,1)~=size(labs1,1))        % dopóki ci¹gle nastepuje ³¹czenie
    labs0=labs1;
    for i=1:size(labs0)                     % analizuj ka¿dy blok, pocz¹wszy od najwiêkszych
        curblock=labs0(i);                  % etykieta aktualnego bloku
        nblocks=Fun_nblocks(L,curblock);    % znajdŸ bloki s¹siednie
        [maxreg,indmaxreg]=sort(blocksize(nblocks),'descend');  % sortuj s¹siadów wed³ug rozmiarów
        nblocks=nblocks(indmaxreg);         % permutuj s¹siadów
        for nblock=1:size(nblocks,1)        % sprawdŸ ka¿dego s¹siada
%             MM=max(str(curblock).M,str(nblocks(nblock)).M);
%             mm=min(str(curblock).m,str(nblocks(nblock)).m);
            if (abs(str(curblock).avg-str(nblocks(nblock)).avg)<max_dJ)
%             if (var(J([str(curblock).ind; str(nblocks(nblock)).ind]))<0.1)
%             if (MM-mm<=max_dJ)
                L(str(nblocks(nblock)).ind)=curblock;               % jeœli spe³niaj¹ kryterium podobieñstwa - po³¹cz bloki
                str(curblock).ind=[ str(curblock).ind;
                                    str(nblocks(nblock)).ind];
%                 str(curblock).M=MM;
%                 str(curblock).m=mm;
                str(curblock).avg=mean(J(str(curblock).ind));
                blocksize(curblock)=blocksize(curblock)+blocksize(nblocks(nblock));
                blocksize(nblocks(nblock))=0;
            end
        end
    end
    [L,labs1,blocksize,str]=Fun_refreshlabels(L,blocksize,str);     % usuñ bloki nieistniej¹ce, posortuj i przenumeruj wg porz¹dku malej¹cego
    itcnt=itcnt+1;
    info=['Iteracja ',int2str(itcnt),':    Liczba obszarow:  ',int2str(size(labs1,1))];   disp(info);
end