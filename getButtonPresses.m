function r = getButtonPresses(ljHandle,BTNMAP,LJ_ioGET_DIGITAL_BIT)
    r = zeros(1,length(BTNMAP));        %%Initilize array with the size of the BTNMAP
    for n = 1:length(BTNMAP)
        [Error r(n)]= ljud_eGet(ljHandle, LJ_ioGET_DIGITAL_BIT,BTNMAP(n),0,0);
    end
    r = ~r;
end