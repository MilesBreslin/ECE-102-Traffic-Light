clear global

%% Load Data

f_PINMAP =		'pinmap.dat';
f_CYCLEMAP =	'cyclemap.dat';

PINMAP =	importdata(f_PINMAP);
CYCLEMAP =	importdata(f_CYCLEMAP);

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

while ~DONE
	for n = 1:length(CYCLEMAP(:,1))
		SetCycle(ljHandle,CYCLEMAP(n,:),PINMAP, LJ_ioPUT_DIGITAL_BIT);							%%Selected On
        fprintf("SET Cycle %d\n",n);
		pause(CYCLEMAP(n,end));
		%%SetCycle(CYCLEMAP(n,:) *.5,PINMAP);						%%Selected "Yellow" simulated as 50% intensity
		%%pause(2);
		SetCycle(ljHandle,zeros(1,length(CYCLEMAP(1,:))), PINMAP, LJ_ioPUT_DIGITAL_BIT);		%%All Off
        fprintf("CLEAR Cycle %d\n",n);
		pause(3);
	end
end
