clear global

%% Load Data

f_PINMAP =		'pinmap.dat';
f_CYCLEMAP =	'cyclemap.dat';

PINMAP =	importdata(f_PINMAP);
CYCLEMAP =	importdata(f_CYCLEMAP);

yellowTime = 0;
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

while ~DONE
	for n = 1:length(CYCLEMAP(:,1))
		tic
		while (((toc/CYCLEMAP(n,end)) + yellowTime + redTime) <= 1)
			if ((toc/CYCLEMAP(n,end) <= 1)		%%GreenTime
				SetCycle(ljHandle,CYCLEMAP(n,:),PINMAP, LJ_ioPUT_DIGITAL_BIT);
			elseif (((toc/CYCLEMAP(n,end))+ yellowTime) = 1)	%%YellowTime
				SetCycle(ljHandle,CYCLEMAP(n,:),PINMAP, LJ_ioPUT_DIGITAL_BIT); %%Unimplemented
			else   %%RedTime
				SetCycle(ljHandle,zeros(1,length(CYCLEMAP(1,:))), PINMAP, LJ_ioPUT_DIGITAL_BIT);				
			end
			pause(.1);
		end
	end
end
