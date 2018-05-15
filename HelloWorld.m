clear global

%% Load Data

f_PINMAP =		'pinmap.dat';
f_CYCLEMAP =	'cyclemap.dat';

PINMAP =	importdata(f_PINMAP);
CYCLEMAP =	importdata(f_CYCLEMAP);

%% Load Labjack

ljud_LoadDrivers
ljud_Constants

[Error ljHandle] = ljud_OpenLabJack(LJ_dtU3,LJ_ctUSB,'1',1);
Error_Message(Error);
if (Error ~= 0)
	return
end

%% Main Loop

DONE = false;		%%Allow Safe escape if implemented

while ~DONE
	for n = 1:length(CYCLEMAP(:,1))
		SetCycle(CYCLEMAP(n,:),PINMAP);							%%Selected On
		sleep(CYCLEMAP(end,n));
		SetCycle(CYCLEMAP(n,:) *.5,PINMAP);						%%Selected "Yellow" simulated as 50% intensity
		sleep(2);
		SetCycle(zeros(1,length(CYCLEMAP(1,:))), PINMAP);		%%All Off
		sleep(3);
	end
end