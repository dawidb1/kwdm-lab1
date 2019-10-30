classdef Config
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    properties
        serie = 'DANE\SERIE';
        names = dir('DANE\SERIE\*.mat');

        wyniki = 'DANE\WYNIKI';
        namesOut = dir('DANE\WYNIKI\*.mat');
    end
end

