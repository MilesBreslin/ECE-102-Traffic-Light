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

%% Extra Declarations
c = CYCLEMAP(n,:);          %%Only pull the active cycle
cycle = c(1:end-1);
w = WALKMAP(n,:);
wcycle = w(1:end-1);
clear c;
clear w;

%% Main Loop

while(true)
    fprintf("Welcome to the Traffic Menu\n")
    fprintf("Enter the number corresponding to the action you want to run.\n\n")
    fprintf("[-1] Exit\n")
    fprintf("[1] Set Traffic\n")
    fprintf("[2] Set Walk\n")
    fprintf("[4] Check Buttons\n")
    try
        user_i = input("Input Diagnostic: ");
        if ismatrix(user_i)
            error("Its a matrix");
        end
    catch
        fprintf("Invalid Input\n")
    end

    switch user_i
        case -1
            fprintf("Exiting...\n")
            break;
        case 1
            fprintf("Setting Traffic\n");
            while(true)
                try
                    user_a = input("Direction: ");
                    if ismatrix(user_a)
                        error("Its a matrix");
                    end
                catch
                    fprintf("Invalid Input\n")
                    clear user_a;
                end
                if (user_a == -1)
                    break;
                end
                if (user_a < length(WALKPINMAP(:,1)))
                    try
                        user_b = input("Direction: ");
                        if ismatrix(user_b)
                            error("Its a matrix");
                        end
                    catch
                        fprintf("Invalid Input\n")
                    end
                    cycle(user_a) = user_b;
                    SetCycle(ljHandle,  cycle, WALKPINMAP, LJ_ioPUT_DIGITAL_BIT);
            end
        case 2
            fprintf("Setting Walk\n")
            while(true)
                try
                    user_a = input("Direction: ");
                    if ismatrix(user_a)
                        error("Its a matrix");
                    end
                catch
                    fprintf("Invalid Input\n")
                    clear user_a;
                end
                if (user_a == -1)
                    break;
                end
                if (user_a < length(WALKPINMAP(:,1)))
                    try
                        user_b = input("Direction: ");
                        if ismatrix(user_b)
                            error("Its a matrix");
                        end
                    catch
                        fprintf("Invalid Input\n")
                    end
                    wcycle(user_a) = user_b
                    SetCycle(ljHandle,  wcycle, WALKPINMAP, LJ_ioPUT_DIGITAL_BIT);
            end
        case 3
            fprintf("Checking Buttons\n")
            tic
            while(toc<15)
                BUTTONS = getButtonPresses(ljHandle,BTNMAP,LJ_ioGET_DIGITAL_BIT)
            end
        otherwise
            fprintf("Invalid Selection\n");
    end
end