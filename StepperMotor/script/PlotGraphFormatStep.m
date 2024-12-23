% Define the base name and constants (mode and pulse)
baseName = 'AngVelo'; % Replace 'name' with the base name of your variable
mode = 1;          % Replace with your mode value
pulse = 100;        % Replace with your frequency value

% Construct the variable name dynamically
varName = sprintf('%s_%d_%d', baseName, mode, pulse);
Title = sprintf('%s Mode : %d Freq : %d', baseName, mode, pulse);

% Check if the variable exists in the workspace
if evalin('base', sprintf('exist(''%s'', ''var'')', varName))
    % Retrieve the variable from the workspace
    data = evalin('base', varName);
    
    % Generate time vector (if not already included in the data)
    time = 1:size(data, 1); % Assuming one row per sample
    
    % Plot the data
    plot(time, data, 'LineWidth', 2);
    xlabel('Time (samples)', 'FontSize', 14);    % Adjust font size to 14
    ylabel(baseName, 'FontSize', 14);            % Adjust font size to 14
    title(sprintf('Plot of %s', Title), 'FontSize', 18); % Adjust font size to 16
    grid on;
else
    disp('Variable does not exist in the workspace.');
end
