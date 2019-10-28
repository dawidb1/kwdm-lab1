function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 28-Oct-2019 15:48:25

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
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)
names=dir('DANE\SERIE\*.mat'); 
set(handles.listFiles, 'string', {names.name});
% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in listFiles.
function listFiles_Callback(hObject, eventdata, handles)
% hObject    handle to listFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listFiles contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listFiles
path = 'DANE\SERIE';
k = get(handles.listFiles,'Value');
names = dir('DANE\SERIE\*.mat'); 
file = load(fullfile(path,names(k,1).name));
n = size(file.s.serie,1);
% I = double(file.s.serie{n,1});
% slices = size(I,3);
indexes = 1:1:n;
set(handles.listSeries, 'string', indexes);

% --- Executes during object creation, after setting all properties.
function listFiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in listSeries.
function listSeries_Callback(hObject, eventdata, handles)
% hObject    handle to listSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listSeries contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listSeries
pathData = 'DANE\SERIE';
names=dir('DANE\SERIE\*.mat');

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
% hObject    handle to listSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in listPrzek.
function listPrzek_Callback(hObject, eventdata, handles)
% hObject    handle to listPrzek (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listPrzek contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listPrzek
path = 'DANE\SERIE';
k = get(handles.listFiles,'Value');

n = get(handles.listSeries,'Value');
names = dir('DANE\SERIE\*.mat'); 
file = load(fullfile(path,names(k,1).name));
I = double(file.s.serie{n,1}); 
m = get(handles.listPrzek,'Value');
I2 = I(:,:,m);
imshow(I2,[],'Parent',handles.photoOne);

pathOut = 'DANE\WYNIKI';
namesOut = dir('DANE\WYNIKI\*.mat');
fileOut = load(fullfile(pathOut,namesOut(k,1).name));
img = double(file.s.serie{n,1}(:,:,m)); 
a = get(get(handles.uibuttongroup1,'SelectedObject'), 'String');
x=1;
if(a == 'Maska 2')
    x=2;
end
maska = double(fileOut.r.maska{x,1});
mask = maska(:,:,m); 
z = wljoin(img, mask, [0.5 1 0.5], 'be');
imshow(z, 'Parent', handles.photoSecond);
set(handles.halfAutomaticSegmentation, 'enable', 'on');
handles.file = file;
handles.n = n;
handles.m = m;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function listPrzek_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listPrzek (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function sliderBright_Callback(hObject, eventdata, handles)
% hObject    handle to sliderBright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global im2
val=0.1*get(hObject,'Value')-0.1;
imbright=im2+val;
axes(handles.photoOne);
imshow(imbright);
impixelinfo

% --- Executes during object creation, after setting all properties.
function sliderBright_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderBright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function sliderContrast_Callback(hObject, eventdata, handles)
% hObject    handle to sliderContrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global im2
val=0.1*get(hObject,'Value')-0.1;
imcontrast=im2+val;
axes(handles.photoOne);
imshow(imcontrast);
impixelinfo

% --- Executes during object creation, after setting all properties.
function sliderContrast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderContrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in halfAutomaticSegmentation.
function halfAutomaticSegmentation_Callback(hObject, eventdata, handles)
% hObject    handle to halfAutomaticSegmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
m = handles.m;
n = handles.n;
file = handles.file;

I = double(file.s.serie{n,1}); 
img = I(:,:,m);

global mask;
imshow(img,[], 'Parent', handles.photoOne);
assignin('base','image',img);
set(gcf, 'WindowButtonDownFcn', 'VW_jc([], [],''SelectMouseDown'', image)');
while isempty(mask)==1
    pause(3);
end;
maska = mask;
assignin('base','maska',mask);

imshow(img,[], 'Parent', handles.photoOne);
 l = 10
res=activecontour(img,mask,l);
z = wljoin(img, res, [0.5 1 0.5], 'be')
imshow(z, 'Parent', handles.photoOne);

handles.maskaseg = mask;
handles.newImg=z;
guidata(hObject, handles);

% --- Executes on button press in automaticSegmentation.
function automaticSegmentation_Callback(hObject, eventdata, handles)
% hObject    handle to automaticSegmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in saveBtn.
function saveBtn_Callback(hObject, eventdata, handles)
% hObject    handle to saveBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%fig = handles.newImg;

% seriadozapisu = load(fullfile('DANE/WYNIKI/',handles.dataName));
% seriadozapisu.r.maska{end+1,1}=handles.maski;
% global username
%opis = get(handles.edit1,'String');
%seriadozapisu.r.maska{end,2}=opis; Je?li chcemy zapisywa? z opisem
% seriadozapisu.r.maska{end,3}=username;
% seriadozapisu.r.maska{end,4}=datestr(clock);
% r=seriadozapisu.r;
% save(['DANE/WYNIKI/' handles.dataName], 'r');

% --- Executes on button press in undoBtn.
function undoBtn_Callback(hObject, eventdata, handles)
% hObject    handle to undoBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathOut = 'DANE\WYNIKI';
k = get(handles.listFiles,'Value');

m = get(handles.listPrzek,'Value');
namesOut = dir('DANE\WYNIKI\*.mat');
fileOut = load(fullfile(pathOut,namesOut(k,1).name));
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
set(handles.edit1,'string',sum3);

% --- Executes on selection change in listboxResults.
function listboxResults_Callback(hObject, eventdata, handles)
% hObject    handle to listboxResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxResults contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxResults

% --- Executes during object creation, after setting all properties.
function listboxResults_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
