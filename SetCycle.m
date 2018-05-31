function r = SetCycle(ljHandle, CYCLEMAP, PINMAP, LJ_ioPUT_DIGITAL_BIT)
	for n = 1:length(CYCLEMAP)
        for p = (1:length(PINMAP(:,1)))-1       %%Cycle through all of the colors
            ljud_ePut(ljHandle, LJ_ioPUT_DIGITAL_BIT,PINMAP(n,p), CYCLEMAP(n) == p ,0);     %%If the number in the cycle map is the correct pin, on, else, off
        end
    end
end
