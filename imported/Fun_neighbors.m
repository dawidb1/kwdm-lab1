function [sasiedzi]=Fun_neighbors(c,w,k,sasiedztwo)
%% LABORATORIUM PRZETWARZANIA OBRAZ�W
%% Pawe� Badura 2009
%% 
%% Funkcja zwracaj�ca indeksy sasiad�w piksela c

switch sasiedztwo
    case 4
        sasiedzi=[                  c(1)-1,c(2);
                    c(1),c(2)-1;                    c(1),c(2)+1;
                                    c(1)+1,c(2)];
    case 8
        sasiedzi=[  c(1)-1,c(2)-1;  c(1)-1,c(2);    c(1)-1,c(2)+1;
                    c(1),c(2)-1;                    c(1),c(2)+1;
                    c(1)+1,c(2)-1;  c(1)+1,c(2);    c(1)+1,c(2)+1];
end
% kontrola brzeg�w obrazu
ind_OK=find( (sasiedzi(:,1)>0) & (sasiedzi(:,1)<=w) & (sasiedzi(:,2)>0) & (sasiedzi(:,2)<=k) );
sasiedzi=sasiedzi(ind_OK,:);