function varargout = aL(varargin)
% AL MATLAB code for aL.fig
%      AL, by itself, creates a new AL or raises the existing
%      singleton*.
%
%      H = AL returns the handle to a new AL or the handle to
%      the existing singleton*.
%
%      AL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AL.M with the given input arguments.
%
%      AL('Property','Value',...) creates a new AL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before aL_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to aL_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help aL

% Last Modified by GUIDE v2.5 02-Dec-2017 21:14:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @aL_OpeningFcn, ...
                   'gui_OutputFcn',  @aL_OutputFcn, ...
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


% --- Executes just before aL is made visible.
function aL_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to aL (see VARARGIN)

% Choose default command line output for aL
handles.output = hObject;

%sliderValue;
%number_of_points;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes aL wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = aL_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global sliderValue;
global number_of_points;
global flag_value;
global start_point;

sliderValue = get(handles.slider1,'Value');
set(handles.epsilon_value, 'String', sliderValue);
[loc_mat,adj_mat,G] = adj_mat_gen(number_of_points,20,flag_value);
%[loc_mat,adj_mat,G] = adj_mat_gen(number_of_points,20);
[sym_mat,G_MST] = core_algo(adj_mat,sliderValue,start_point);
plot(handles.axes1,G_MST,'XData',loc_mat(1,:),'YData',loc_mat(2,:),'EdgeLabel',G_MST.Edges.Weight);

total_weight = sum(sum(sym_mat))/2;
radius_max = max(sym_mat(start_point,:));

radius_string = int2str(radius_max);
weight_string = int2str(total_weight);

set(handles.mst_weight,'String',weight_string);
set(handles.radius1_value, 'String', radius_string);

guidata(hObject,handles); 


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
handles.tag=hObject;
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
guidata(hObject,handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global sliderValue;
global number_of_points;
global flag_value;
global start_point;
global slider2Value;

sliderValue = 0;
slider2Value = 0;

number_of_points = str2double(char(get(handles.edit1,'String')));
flag_value = str2double(char(get(handles.flag,'String')));
start_point = str2double(char(get(handles.source,'String')));

set(handles.slider2,'Value',get(handles.slider2,'Min'));
set(handles.slider1,'Value',get(handles.slider1,'Min'));

% Algorithm 1
[loc_mat,adj_mat,G] = adj_mat_gen(number_of_points,20,flag_value);
[sym_mat,G_MST] = core_algo(adj_mat,sliderValue,start_point);
set(handles.epsilon_value, 'String', '0'); 
plot(handles.axes1,G_MST,'XData',loc_mat(1,:),'YData',loc_mat(2,:),'EdgeLabel',G_MST.Edges.Weight);

total_weight = sum(sum(sym_mat))/2;
radius_max = max(sym_mat(start_point,:));

weight_string = int2str(total_weight);
radius_string = int2str(radius_max);

set(handles.mst_weight,'String',weight_string);
set(handles.radius1_value, 'String', radius_string);

% Algorithm 2
[loc_mat,adj_mat,G] = adj_mat_gen(number_of_points,20,flag_value);
[bounded_radi_mat,G_MST_bound] = bounded_radius(adj_mat,slider2Value,start_point);
set(handles.epsilon2_value, 'String', '0'); 
plot(handles.axes2,G_MST_bound,'XData',loc_mat(1,:),'YData',loc_mat(2,:),'EdgeLabel',G_MST_bound.Edges.Weight);

total_weight = sum(sum(bounded_radi_mat))/2;
radius_max = max(bounded_radi_mat(start_point,:));

radius_string = int2str(radius_max);
weight_string = int2str(total_weight);

set(handles.mst2_weight,'String',weight_string);
set(handles.radius2_value, 'String', radius_string);

guidata(hObject,handles); 

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


% --- Executes during object creation, after setting all properties.
function pushbutton2_CreateFcn(hObject, eventdata, handles)
handles.tag=hObject;
guidata(hObject,handles);
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function flag_Callback(hObject, eventdata, handles)
% hObject    handle to flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of flag as text
%        str2double(get(hObject,'String')) returns contents of flag as a double


% --- Executes during object creation, after setting all properties.
function flag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function source_Callback(hObject, eventdata, handles)
% hObject    handle to source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of source as text
%        str2double(get(hObject,'String')) returns contents of source as a double


% --- Executes during object creation, after setting all properties.
function source_CreateFcn(hObject, eventdata, handles)
% hObject    handle to source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global slider2Value;
global number_of_points;
global flag_value;
global start_point;

slider2Value = get(handles.slider2,'Value');
set(handles.epsilon2_value, 'String', slider2Value);
[loc_mat,adj_mat,G] = adj_mat_gen(number_of_points,20,flag_value);
[bounded_radi_mat,G_MST_bound] = bounded_radius(adj_mat,slider2Value,start_point);
%[loc_mat,adj_mat,G] = adj_mat_gen(number_of_points,20);
%[sym_mat,G_MST] = core_algo(adj_mat,sliderValue,start_point);
plot(handles.axes2, G_MST_bound,'XData',loc_mat(1,:),'YData',loc_mat(2,:),'EdgeLabel',G_MST_bound.Edges.Weight);
%plot(handles.axes1,G_MST,'XData',loc_mat(1,:),'YData',loc_mat(2,:),'EdgeLabel',G_MST.Edges.Weight);

total_weight = sum(sum(bounded_radi_mat))/2;
radius_max = max(bounded_radi_mat(start_point,:));

radius_string = int2str(radius_max);
weight_string = int2str(total_weight);

set(handles.mst2_weight,'String',weight_string);
set(handles.radius2_value, 'String', radius_string);

guidata(hObject,handles); 


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.tag=hObject;
guidata(hObject,handles); 


% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
