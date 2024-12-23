nameBase = 'AngVelo'; 
freqBase = 'Freq';    

% Arrays of different values for mode, begin, endVal, and step
modes = [1,2,3,4,5,6];
begins = [1,1,1,1,1,1];
endVals = [3000,7000,20000,40000,50000,100000];
steps = [1,1,1,1,1,1];    % Example step array

% Initialize a figure for the 2D plot
figure;
hold on; % Enable overlaying multiple plots

% Loop through each combination of mode, begin, endVal, and step
for i = 1:length(modes)
    % Access values from the predefined arrays (since they are ordered)
    mode = modes(i);
    begin = begins(i);
    endVal = endVals(i);
    step = steps(i);

    % Construct variable names dynamically for x and y data
    yVarName = sprintf('%s_%d_%d_%d_%d', nameBase, mode, begin, endVal, step);
    xVarName = sprintf('%s_%d_%d_%d_%d', freqBase, mode, begin, endVal, step);

    % Check if both variables exist in the workspace
    if evalin('base', sprintf('exist(''%s'', ''var'')', yVarName)) && ...
       evalin('base', sprintf('exist(''%s'', ''var'')', xVarName))

        % Retrieve variables from the workspace
        yData = evalin('base', yVarName);
        xData = evalin('base', xVarName);

        % Ensure xData and yData are of compatible sizes
        if length(xData) ~= length(yData)
            error('xData and yData must have the same length.');
        end

        % Plot the data in 2D
        plot(xData, yData, 'LineWidth', 2, 'DisplayName', sprintf('Mode: %d', mode));
    else
        disp(['Variable ' yVarName ' or ' xVarName ' does not exist in the workspace.']);
    end
end

% Customize the 2D plot
xlabel('Frequency (Hz)', 'FontSize', 14);
ylabel('Angular Velocity (rad/s)', 'FontSize', 14);
title('Frequency vs. Angular Velocity for Different Modes', 'FontSize', 18);

legend('show', 'Location', 'best'); % Show legend with parameter combinations
grid on;
hold off; % Release the plot hold
