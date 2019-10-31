function [L2disp]=Fun_unlabel(L)
%% LABORATORIUM PRZETWARZANIA OBRAZ�W
%% Pawe� Badura 2009
%% 
%% Funkcja wyodr�bniaj�ca granice mi�dzy blokami w macierzy etykiet

L2disp=false(size(L));
Ltemp=imfilter(L,[-1 1],'replicate');       % kraw�dzie pionowe
L2disp(find(Ltemp))=true;
Ltemp=imfilter(L,[-1; 1],'replicate');      % kraw�dzie poziome
L2disp(find(Ltemp))=true;