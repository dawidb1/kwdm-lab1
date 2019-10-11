names=dir('DANE\SERIE\*.mat');


for k=1:size(names)
load(fullfile(names(k,1).folder,names(k,1).name));
end