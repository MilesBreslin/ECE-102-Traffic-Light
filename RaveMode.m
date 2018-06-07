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

    x = randi(4);
    r = -1;
    if (x <= 2)
        pause(r/4);
    elseif (x ==3)
        pause(1);
    elseif (x == 4)
        r = randi(16)
    end

    b = randi(4);
    a = randi(3);
    if (a >= b)
        a = a + 1;
    end
    c(1) = b -1;
    c(2) = a -1;
    clear b;

    if (randi(4) == 1)
        q = wcycle;
        wcycle = cycle;
        cycle = wcycle;
        clear q;
    else
        wcycle = rand(2,1,length(wcycle));
        cycle = rand(2,1,length(cycle));
        for q = 1:length(cycle)
            cycle(q) = c(cycle(q));
        end
        for q = 1:length(wcycle)
            wcycle(q) = c(wcycle(q));
        end
    end
    
    if (r <= 3)
        tic
        if (randi(4)<=3)
            q = false;
            time = randi(2);
            freq = randi(4);
            SetCycle(ljHandle, cycle ,PINMAP,     LJ_ioPUT_DIGITAL_BIT);
            while(toc<time/4)
                q = ~q;
                if (q)
                    SetCycle(ljHandle, wcycle ,WALKPINMAP,     LJ_ioPUT_DIGITAL_BIT);
                else
                    SetCycle(ljHandle, zeros(1,length(wcycle))-1 ,WALKPINMAP,     LJ_ioPUT_DIGITAL_BIT);
                end
                pause(freq/32);
            end
        else
            q = false;
            time = randi(2);
            freq = randi(4);
            SetCycle(ljHandle, wcycle ,WALKPINMAP,     LJ_ioPUT_DIGITAL_BIT);
            while(toc<time/4)
                q = ~q;
                if (q)
                    SetCycle(ljHandle, cycle ,PINMAP,     LJ_ioPUT_DIGITAL_BIT);
                else
                    SetCycle(ljHandle, zeros(1,length(cycle))-1 ,PINMAP,     LJ_ioPUT_DIGITAL_BIT);
                end
                pause(freq/32);
            end
        end
    elseif (r <= 6)
        tic
        if (r == 4)
            s = 1;
        else
            s = 2;
        end
        numba = randi(3);
        while(toc<1)
            numba = numba + 1;
            cycle = cycle + 1;
            wcycle = wcycle +1;
            wcycle = mod(wcycle,randi(2)+1);
            cycle = mod(cycle,randi(2)+2);
            SetCycle(ljHandle, cycle ,PINMAP,     LJ_ioPUT_DIGITAL_BIT);
            SetCycle(ljHandle, wcycle ,WALKPINMAP,     LJ_ioPUT_DIGITAL_BIT);
            pause(s/4)
        end
    elseif (r == -1)
        SetCycle(ljHandle, cycle ,PINMAP,     LJ_ioPUT_DIGITAL_BIT);
        SetCycle(ljHandle, wcycle ,WALKPINMAP,     LJ_ioPUT_DIGITAL_BIT);
    end
end