clear
clear global

%% Load Data

f_PINMAP =		'cyclepinmap.dat';
f_CYCLEMAP =	'cyclemap.dat';

f_WALKPINMAP =	'walkpinmap.dat';
f_WALKMAP =		'walkmap.dat';

PINMAP =		importdata(f_PINMAP);
CYCLEMAP =		importdata(f_CYCLEMAP);

WALKPINMAP =	importdata(f_WALKPINMAP);
WALKMAP =		importdata(f_WALKMAP);

BTNMAP =		WALKMAP(:,end);		%%Last Column is the button pins

walkTime = 3;
yellowTime = 2;
redTime = 3;

%% Load Labjack

ljud_LoadDriver
ljud_Constants

[Error ljHandle] = ljud_OpenLabJack(LJ_dtU3,LJ_ctUSB,'1',1);
Error_Message(Error);
if (Error ~= 0)
	return
end

%% Main Loop

DONE = false;		%%Allow Safe escape if implemented
activeWalk = 	zeros(1,length(CYCLEMAP(:,1)));		%%Create the Button buffer

while ~DONE
	for n = 1:length(CYCLEMAP(:,1))
		tic
		c =	CYCLEMAP(n,:);			%%Only pull the active cycle
        cycle = c(1:end-1);
		time = 	CYCLEMAP(n,end);				%%Exclude the last value for time
		
        w = WALKMAP(n,:);
        wcycle = w(1:end-1) & activeWalk;
		if (time<walkTime)		%%Gotta be larger than the walk time
			time = walkTime;
        end

		while (toc/(time + yellowTime + redTime) <= 1)
			if (toc/(time - walkTime) <= 1)									%%GreenTime
				SetCycle(ljHandle,	cycle*2,PINMAP,		LJ_ioPUT_DIGITAL_BIT);		%%Use 3rd column
				SetCycle(ljHandle,	wcycle,	WALKPINMAP,	LJ_ioPUT_DIGITAL_BIT);
			elseif (toc/time <= 1)											%%WalkFlash
				SetCycle(ljHandle,	cycle*2,PINMAP, 	LJ_ioPUT_DIGITAL_BIT);
				SetCycle(ljHandle,	wcycle & (mod(ceil(toc-walkTime),2)),	WALKPINMAP,	LJ_ioPUT_DIGITAL_BIT);

			elseif (toc/(time+ yellowTime) <= 1)							%%YellowTime
				SetCycle(ljHandle,	cycle,	PINMAP,		LJ_ioPUT_DIGITAL_BIT);		%%Signal the SetCycle to use the yellow light
				SetCycle(ljHandle,	zeros(1,length(wcycle)),	WALKPINMAP,	LJ_ioPUT_DIGITAL_BIT);

			else															%%redTime
				SetCycle(ljHandle,	zeros(1,length(cycle)), PINMAP, LJ_ioPUT_DIGITAL_BIT);
				SetCycle(ljHandle,	zeros(1,length(wcycle)),	WALKPINMAP,	LJ_ioPUT_DIGITAL_BIT);
			end

			activeWalk = activeWalk | getButtonPresses(ljHandle,BTNMAP,LJ_ioGET_DIGITAL_BIT);		%%Add buttons being pressed only
			pause(.1)
		end

		activeWalk(n) = 0;		%%Clear walk buffer *after* it is done displaying.
	end
end
