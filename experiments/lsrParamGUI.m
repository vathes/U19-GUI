function vr= lsrParamGUI(vr)

epochList   =   {'whole+reward';'whole';'cue';'cueHalf2';'cueHalf1';'mem'; ...
               'memHalf1';'choice';'reward';'iti';'reward+iti';'Alt_Cue_Outcome'}; % trial epoch options@
ss = get(groot,'screensize');
ss = ss(3:4);
fig         = figure('Name',           'Laser Control',    ...
               'NumberTitle',          'off',              ...
               'Tag',                  'fig',              ...
               'Position',              round([ss(1)*.4 ss(2)*.4 ss(1)*.2 ss(2)*.3]));
pON_txt     = uicontrol ('Parent',     fig,                ...
               'Style',                'text',             ...
               'String',               'P (on):',          ...
               'Units',                'normalized',       ...
               'Position',             [.02 .65 .35 .20],  ...
               'horizontalAlignment',  'right',            ...
               'fontsize',             14);                     
pON         = uicontrol ('Parent',     fig,                ...
               'Style',                'edit',             ...
               'Units',                'normalized',       ...
               'String',               num2str(0.2),       ...
               'Position',             [.55 .72 .35 .18],  ...
               'Callback',             {@pON_callback},    ...
               'fontsize',             13,                 ...
               'Tag',                  'editbox');
epoch_txt   = uicontrol ('Parent',     fig,                ...
               'Style',                'text',             ...
               'String',               'Trial epoch:',     ...
               'Units',                'normalized',       ...
               'Position',             [.02 .35 .45 .25],  ...
               'horizontalAlignment',  'right',            ...
               'fontsize',             14);
epoch       = uicontrol ('Parent',     fig,                ...
               'Style',                'popupmenu',        ...
               'Units',                'normalized',       ...
               'String',               epochList,          ...
               'Value',                1,                  ...
               'Position',             [.55 .36 .4 .25],   ...
               'Callback',             {@epoch_callback},  ...
               'fontsize',             13,                 ...
               'Tag',                  'popup');                   
ready        = uicontrol ('Parent',    fig,                ...
               'String',               'GO!',              ...
               'Style',                'pushbutton',       ...
               'Units',                'normalized',       ...
               'Position',             [.33 .10 .33 .25],  ...
               'Callback',             {@ready_callback},  ...
               'foregroundcolor',      [0 .5 0],           ...
               'fontsize',             14,                 ...
               'horizontalAlignment',  'center',           ...
               'fontweight',           'bold',             ...
               'Tag',                  'ready');
uiwait()
vr.P_on     = str2double(get(pON,'String'));
vr.lsrepoch = epochList{get(epoch,'Value')};
close(gcf)

%% callbacks
% set laser ON trial probability with input box
function vr=pON_callback(hObject,eventdata,handles)
         P_on = str2double(get(hObject,'String'));
         set(hObject,'String',num2str(P_on));
guidata(hObject,eventdata)

% select laser ON trial epoch with drop down menu
function vr=epoch_callback(hObject,eventdata,handles)
         epochList   =   {'whole+reward';'whole';'cue';'cueHalf2';'cueHalf1';'mem'; ...
                          'memHalf1';'choice';'reward';'iti';'reward+iti';'Alt_Cue_Outcome'}; % trial epoch options
         lsrepoch = epochList{get(hObject,'Value')};
         vr.lsrepoch = lsrepoch;
guidata(hObject,eventdata)
   
% start virmen experiment after go button press
function vr=ready_callback(hObject,eventdata,handles)
uiresume()