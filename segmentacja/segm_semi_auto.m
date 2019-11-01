function [outputArg1,outputArg2] = segm_semi_auto(handles)
img = getImage(handles);

global mask;
mask = [];
imshow(img,[], 'Parent', handles.axes1);
assignin('base','image',img);
set(gcf, 'WindowButtonDownFcn', 'VW_jc([], [],''SelectMouseDown'', image)');
while isempty(mask)==1
    pause(3);
end;

assignin('base','maska',mask);

imshow(img,[], 'Parent', handles.axes1);
l = 10
res=activecontour(img,mask,l);
z = wljoin(img, res, [0.5 1 0.5], 'be')
imshow(z, 'Parent', handles.axes1);

outputArg1 = mask;
outputArg2=z;

end

