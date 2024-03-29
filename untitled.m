function varargout = untitled(varargin)
% Last Modified by GUIDE v2.5 01-Nov-2019 23:04:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% hObject    handle to cofnij_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

addpath('load');
addpath('segmentacja');
addpath('imported');
conf = Config;

addpath(conf.serie);
addpath(conf.wyniki);

set(handles.listFiles, 'string', {conf.names.name});
names2=dir('DANE\SEGMENT\*.mat');
set(handles.listbox4, 'string', {names2.name});

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listFiles.
function listFiles_Callback(hObject, eventdata, handles)

conf = Config;
path = conf.serie;

k = get(handles.listFiles,'Value');
file = load(fullfile(path,conf.names(k,1).name));
n = size(file.s.serie,1);
% I = double(file.s.serie{n,1});
% slices = size(I,3);
indexes = 1:1:n;
set(handles.listSeries, 'string', indexes);

% --- Executes during object creation, after setting all properties.
function listFiles_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listSeries.
function listSeries_Callback(hObject, eventdata, handles)

conf = Config;
pathData = conf.serie;
names=conf.names;

k=get(handles.listFiles,'Value');
file=load(fullfile(pathData,names(k,1).name));

n = get(handles.listSeries,'Value');
I = double(file.s.serie{n,1});
slices = size(I,3);
indexes = 1:1:slices;
set(handles.listPrzek, 'string', indexes);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function listSeries_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listPrzek.
function listPrzek_Callback(hObject, eventdata, handles)

conf = Config;
path = conf.serie;

k = get(handles.listFiles,'Value');
n = get(handles.listSeries,'Value');

file = load(fullfile(path,conf.names(k,1).name));

I = double(file.s.serie{n,1}); 


m = get(handles.listPrzek,'Value');
I2 = I(:,:,m);

imshow(I2,[],'Parent',handles.axes1);

pathOut = conf.wyniki;

fileOut = load(fullfile(pathOut,conf.namesOut(k,1).name));
img = double(file.s.serie{n,1}(:,:,m)); 
a = get(get(handles.uibuttongroup1,'SelectedObject'), 'String');
x=1;
if(a == 'Maska 2')
    x=2;
end
maska = double(fileOut.r.maska{x,1});
mask = maska(:,:,m); 
z = wljoin(img, mask, [0.5 1 0.5], 'be');
imshow(z, 'Parent', handles.axes2);
set(handles.segm_pol_auto_radio_btn, 'enable', 'on');
handles.file = file;
handles.n = n;
handles.m = m;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function listPrzek_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sliderBright_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val=int8(10*get(hObject,'Value'));
file = handles.file;
m = handles.m;
n = handles.n;
I = double(file.s.serie{n,1}); 
img = I(:,:,m);
se=ones(val,val);
I2=imdilate(img,se)-img;
imshow(I2,[],'Parent',handles.axes1);

% --- Executes during object creation, after setting all properties.
function sliderBright_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderContrast_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val=int8(10*get(hObject,'Value'));
file = handles.file;
m = handles.m;
n = handles.n;
I = double(file.s.serie{n,1}); 
img = I(:,:,m);
se=ones(val,val)
I2=imdilate(img,se);
imshow(I2,[],'Parent',handles.axes1);

% --- Executes during object creation, after setting all properties.
function sliderContrast_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in segm_auto_btn.
function segm_auto_btn_Callback(hObject, eventdata, handles)

% --- Executes on button press in zapisz_btn.
function zapisz_btn_Callback(hObject, eventdata, handles)
 
img = handles.newImg;

mask=handles.maskaseg;

z = wljoin(img, mask, [0.5 1 0.5], 'be');
x = get(handles.edit3,'String'); 
str=strcat('DANE\SEGMENT\', x,'.mat');
save(str,'z')
names2=dir('DANE\SEGMENT\*.mat');
set(handles.listbox4, 'string', {names2.name});

% --- Executes on button press in cofnij_btn.
function cofnij_btn_Callback(hObject, eventdata, handles)

conf = Config;

k = get(handles.listFiles,'Value');
m = get(handles.listPrzek,'Value');

fileOut = load(fullfile(conf.wyniki,conf.namesOut(k,1).name));
a = get(get(handles.uibuttongroup1,'SelectedObject'), 'String');
x=1;
if(a == 'Maska 2')
    x=2;
end
maska = double(fileOut.r.maska{x,1});
mask = maska(:,:,m); 
sum1=sum(mask(:));
mask2=handles.maskaseg;
sum2=sum(mask2(:));
sum3=sum1-sum2;
mask2 = imresize(mask2,size(mask));
dw= 2*nnz(mask&mask2)/(nnz(mask) + nnz(mask2));
set(handles.edit1,'string',sum3);
set(handles.edit2,'string',dw);


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4
path='DANE\SEGMENT';
k = get(handles.listbox4,'Value');
names = dir('DANE\SEGMENT\*.mat'); 
file = load(fullfile(path,names(k,1).name));
imshow(file.z, 'Parent', handles.axes2);

% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit1_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in segm_auto_radio_btn.
function segm_auto_radio_btn_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of segm_auto_radio_btn
img = getImage(handles);
[x,y]=segm_auto(img, handles.axes1);
handles.maskaseg = x;
handles.newImg=y;
guidata(hObject, handles);

% --- Executes on button press in segm_pol_auto_radio_btn.
function segm_pol_auto_radio_btn_Callback(hObject, eventdata, handles)
% TODO podpi?? p�?automatyczn? metod?
[x,y]=segm_semi_auto(handles);
handles.maskaseg = x;
handles.newImg=y;
guidata(hObject, handles);



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
