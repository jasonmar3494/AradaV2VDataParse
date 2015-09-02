clear
clc
close all

d = dir('.');
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
for i=1:length(nameFolds)
    d = dir([nameFolds{i} '/*.xml']);
    for k=1:length(d)
        if exist([nameFolds{i} '/' d(k).name] , 'file') == 2
            fid = fopen([nameFolds{i} '/' d(k).name], 'a+');
            fprintf(fid, '%s','</BIGLOGFILE>');
            fclose(fid);
            continue
        end
    end
end