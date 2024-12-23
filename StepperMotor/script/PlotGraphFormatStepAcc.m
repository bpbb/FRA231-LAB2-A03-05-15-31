nameBase = 'Pulse';
freqBase = 'Freq';

mode = 1;    
begin = 1;
endVal = 3000;
step = 1;  

% Construct variable names dynamically
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

    % Plot data
    plot(xData, yData); % Line plot with markers
    xlabel(sprintf('Frequency'), 'Interpreter', 'none','FontSize',16);
    ylabel(sprintf('Angular Velocity (rad/s)'), 'Interpreter', 'none','FontSize',16);
    title('Frequency vs. Angular Velocity In Half Step Drive','FontSize',18);
    grid on;

    % Adjust y-axis to start at the first value of yData
    yMin = yData(2); % Get the first value of yData
    ylim([yMin max(yData)]); % Set y-axis limits from the first value to the max value
else
    disp('One or both variables do not exist in the workspace.');
end
