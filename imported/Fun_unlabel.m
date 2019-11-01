function [L2disp]=Fun_unlabel(L)
%% LABORATORIUM PRZETWARZANIA OBRAZÓW
%% Pawe³ Badura 2009
%% 
%% Funkcja wyodrêbniaj¹ca granice miêdzy blokami w macierzy etykiet

L2disp=false(size(L));
Ltemp=imfilter(L,[-1 1],'replicate');       % krawêdzie pionowe
L2disp(find(Ltemp))=true;
Ltemp=imfilter(L,[-1; 1],'replicate');      % krawêdzie poziome
L2disp(find(Ltemp))=true;