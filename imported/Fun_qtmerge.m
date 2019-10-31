function [L]=Fun_qtmerge(J,S,max_dJ)
%% LABORATORIUM PRZETWARZANIA OBRAZ�W
%% Pawe� Badura 2009
%% 
%% Funkcja realizuj�ca faz� ��czenia blok�w

% Macierz etykiet blok�w
L=zeros(size(S));                           % inicjalizacja macierzy L
str=struct('ind',{});                       % pomocnicza struktura do indeks�w pikseli bloku
indS=find(S);                               % znajd� indeksy znacznik�w wszystkich blok�w (rozmiar boku w lewym g�rnym rogu)
[iy,ix]=ind2sub(size(S),indS);              % przejd� na podw�jne indeksy
[maxreg,indmaxreg]=sort(nonzeros(S),'descend'); % sorotwanie blok�w malej�co wg rozmiar�w
for lab=1:size(iy,1)                        % etykietowanie blok�w pocz�wszy od najwi�kszych
    a=S(indS(indmaxreg(lab)));              % d�ugo�� boku bloku lab
    L(iy(indmaxreg(lab)):iy(indmaxreg(lab))+a-1,ix(indmaxreg(lab)):ix(indmaxreg(lab))+a-1)=lab*ones(a);     % wype�nij ca�y blok etykiet� lab
    str(lab).ind=find(L==lab);              % indeksy punkt�w bloku
%     str(lab).M=max(J(str(lab).ind));        % maksymalna intensywno�� w bloku
%     str(lab).m=min(J(str(lab).ind));        % minimalna intensywno�� w bloku
    str(lab).avg=mean(J(str(lab).ind));     % �rednia intensywno�� w bloku
    blocksize(lab)=a*a;                     % liczba pikseli obiektu
end
labs0=0; labs1=unique(L);                   % labs1 - wektor z etykietami blok�w
info=['  ===  FAZA PODZIALU  ==='];   disp(info);   % informacja
info=['Liczba blokow:  ',int2str(size(labs1,1))];   disp(info);     disp(' ');   % informacja
info=['  ===  FAZA LACZENIA  ==='];   disp(info);   % informacja
itcnt=0;
while (size(labs0,1)~=size(labs1,1))        % dop�ki ci�gle nastepuje ��czenie
    labs0=labs1;
    for i=1:size(labs0)                     % analizuj ka�dy blok, pocz�wszy od najwi�kszych
        curblock=labs0(i);                  % etykieta aktualnego bloku
        nblocks=Fun_nblocks(L,curblock);    % znajd� bloki s�siednie
        [maxreg,indmaxreg]=sort(blocksize(nblocks),'descend');  % sortuj s�siad�w wed�ug rozmiar�w
        nblocks=nblocks(indmaxreg);         % permutuj s�siad�w
        for nblock=1:size(nblocks,1)        % sprawd� ka�dego s�siada
%             MM=max(str(curblock).M,str(nblocks(nblock)).M);
%             mm=min(str(curblock).m,str(nblocks(nblock)).m);
            if (abs(str(curblock).avg-str(nblocks(nblock)).avg)<max_dJ)
%             if (var(J([str(curblock).ind; str(nblocks(nblock)).ind]))<0.1)
%             if (MM-mm<=max_dJ)
                L(str(nblocks(nblock)).ind)=curblock;               % je�li spe�niaj� kryterium podobie�stwa - po��cz bloki
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
    [L,labs1,blocksize,str]=Fun_refreshlabels(L,blocksize,str);     % usu� bloki nieistniej�ce, posortuj i przenumeruj wg porz�dku malej�cego
    itcnt=itcnt+1;
    info=['Iteracja ',int2str(itcnt),':    Liczba obszarow:  ',int2str(size(labs1,1))];   disp(info);
end