while(true)
    fprintf("Traffic Menu\n")
    fprintf("Enter the number corresponding to the action you want to run.\n\n")
    fprintf("[-1] Exit\n")
    fprintf("[1] Load Traffic Cycles\n")
    fprintf("[2] Load Traffic Cycles Double Speed\n")
    fprintf("[3] Diagnostic Mode\n")
    fprintf("[5] Debug Mode\n")

    fprintf("\n")
    try   %%Check if input is valid
        user_i = input('Input: ');
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
            fprintf("Running Main Traffic Cycles\n");
            TrafficCycles
        case 2
            fprintf("Running Main Traffic Cycles\n");
            TrafficCycles
        case 3
            fprintf("Running Diagnostic Mode\n")
            Disagnostic
        case 4
            fprintf("Running Rave Mode\n")
            RaveMode
        case 5
            fprintf("Running Debug Mode\n")
            DebugMode
        otherwise
            fprintf("Invalid Selection\n");
    end
end