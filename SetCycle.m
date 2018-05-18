function r = SetCycle(ljHandle, CYCLEMAP, PINMAP, LJ_ioPUT_DIGITAL_BIT)
	for n = 1:(length(CYCLEMAP)-1)
        if (CYCLEMAP(n)== 0)
            Error = ljud_ePut(ljHandle, LJ_ioPUT_DIGITAL_BIT,PINMAP(n,1),1,0);
            fprintf("%d ON\n%d OFF\n",PINMAP(n,1),PINMAP(n,2))
            Error = ljud_ePut(ljHandle, LJ_ioPUT_DIGITAL_BIT,PINMAP(n,2),0,0);
        else
            Error = ljud_ePut(ljHandle, LJ_ioPUT_DIGITAL_BIT,PINMAP(n,1),0,0);
            fprintf("%d OFF\n%d ON\n",PINMAP(n,1),PINMAP(n,2))
            Error = ljud_ePut(ljHandle, LJ_ioPUT_DIGITAL_BIT,PINMAP(n,2),1,0);
        end
    end
    fprintf("\n\n");
end
