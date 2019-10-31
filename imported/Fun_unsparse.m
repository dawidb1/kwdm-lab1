function [S2disp]=Fun_unsparse(S)
%% LABORATORIUM PRZETWARZANIA OBRAZ�W
%% Pawe� Badura 2009
%%      na podstawie przyk�adu z pomocy Matlaba do funkcji 'qtdecomp'
%% 
%% Funkcja przekszta�caj�ca macierz rzadk� S do normalnej postaci z granicami mi�dzy blokami

S2disp = repmat(uint8(0),size(S));
for dim = [512 256 128 64 32 16 8 4 2 1];    
    numblocks = length(find(S==dim));    
    if (numblocks > 0)        
        values = repmat(uint8(1),[dim dim numblocks]);
        values(2:dim,2:dim,:) = 0;
        S2disp = qtsetblk(S2disp,S,dim,values);
    end
end
S2disp(end,1:end) = 1;
S2disp(1:end,end) = 1;