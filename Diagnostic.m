clear
clear global

%% Load Data

f_PINMAP =      'cyclepinmap.dat';
f_CYCLEMAP =    'cyclemap.dat';

f_WALKPINMAP =  'walkpinmap.dat';
f_WALKMAP =     'walkmap.dat';

PINMAP =        importdata(f_PINMAP);
CYCLEMAP =      importdata(f_CYCLEMAP);

WALKPINMAP =    importdata(f_WALKPINMAP);
WALKMAP =       importdata(f_WALKMAP);

BTNMAP =        WALKMAP(:,end);     %%Last Column is the button pins

%% Load Labjack

ljud_LoadDriver
ljud_Constants

[Error ljHandle] = ljud_OpenLabJack(LJ_dtU3,LJ_ctUSB,'1',1);
Error_Message(Error);
if (Error ~= 0)
    return
end

%% Main Loop

DONE = false;       %%Allow Safe escape
tic
while ~DONE
    btn = getButtonPresses(ljHandle,BTNMAP,LJ_ioGET_DIGITAL_BIT);

    DONE = true;        %%Special Case: All buttons are pressed will safely escape
    for q = 1:length(BTNMAP)
        if (btn(q) == 0)
            DONE = false;
            break;
        end
    end

    cycle = zeros(1, length(PINMAP(:,1)));
    wcycle = zeros(1, length(WALKPINMAP(:,1)));

    if ((mod(ceil(toc),2)))
        cycle = ~cycle;
        wcycle = ~wcycle;
    end

    SetCycle(ljHandle, cycle*5 ,PINMAP,     LJ_ioPUT_DIGITAL_BIT);
    SetCycle(ljHandle, wcycle*5 ,WALKPINMAP,     LJ_ioPUT_DIGITAL_BIT);

    pause(.2);
end
