nameBase = 'AngVelo'; % Replace with the base name for the y-axis data
freqBase = 'Freq';    % Replace with the base name for the x-axis data

% Arrays of different values for mode, begin, endVal, and step
modes = [1,2,3,4,5,6];    % Example mode array
begins = [1,1,1,1,1,1];   % Example begin array
endVals = [3000,7000,20000,40000,50000,100000]; % Example end value array
steps = [1,1,1,1,1,1];    % Example step array

% Initialize a figure for the 3D plot
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

        % Create a zData vector for spacing (constant for each combination of parameters)
        zData = ones(size(xData)) * i; % Use index to separate the curves in 3D space

        % Plot the data in 3D
        plot3(xData, zData, yData, 'LineWidth', 2, 'DisplayName', sprintf('Mode: %d', mode));
    else
        disp(['Variable ' yVarName ' or ' xVarName ' does not exist in the workspace.']);
    end
end

% Customize the 3D plot
xlabel('Frequency (Hz)', 'FontSize', 14);
ylabel('Mode', 'FontSize', 14);
zlabel('Angular Velocity (rad/s)', 'FontSize', 14);
title('Frequency vs. Angular Velocity for Different Modes', 'FontSize', 18);

% Adjust Y-axis ticks and labels based on the number of different combinations
yticks(1:length(modes));
yticklabels(arrayfun(@(x) sprintf('Mode %d', x), modes, 'UniformOutput', false));

legend('show', 'Location', 'best'); % Show legend with parameter combinations
grid on;
view(45, 30); % Adjust the viewing angle
hold off; % Release the plot hold

