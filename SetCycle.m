function r = SetCycle(ljHandle, CYCLEMAP, PINMAP, LJ_ioPUT_DIGITAL_BIT)
	for n = 1:(length(CYCLEMAP)-1)
        ljud_ePut(ljHandle, LJ_ioPUT_DIGITAL_BIT,PINMAP(n,1),~CYCLEMAP(n),0);
        ljud_ePut(ljHandle, LJ_ioPUT_DIGITAL_BIT,PINMAP(n,2), CYCLEMAP(n),0);
    end
end
