baseName = 'AngVelo';
mode = 6;           
Title = sprintf('%s In 1/32 Step Drive', baseName);

% Get all variables in the workspace
vars = evalin('base', 'who');

% Initialize a figure for the plot
figure;
hold on;

% Initialize empty arrays to store pulses and their data
pulseValues = [];
dataList = {};

% Loop through workspace variables to find relevant ones
for i = 1:length(vars)
    varName = vars{i}; % Current variable name
    
    % Check if the variable matches the pattern 'Pulse_mode_<pulse>'
    pattern = sprintf('%s_%d_\\d+', baseName, mode); % Regex for Pulse_mode_number
    if ~isempty(regexp(varName, pattern, 'once'))
        % Extract the pulse value from the variable name
        tokens = regexp(varName, sprintf('%s_%d_(\\d+)', baseName, mode), 'tokens');
        pulse = str2double(tokens{1}{1}); % Convert the pulse value to a number
        
        % Retrieve the variable data
        data = evalin('base', varName);
        
        % Align the data to start at zero
        if data(1) == 0
            data(1) = data(2);
        end
        data = data - data(1);
        
        % Store pulse value and corresponding data
        pulseValues = [pulseValues; pulse];
        dataList{end+1} = data;
    end
end

% Sort the pulse values and reorder the data list
[sortedPulses, sortIdx] = sort(pulseValues); % Sort pulse values
sortedDataList = dataList(sortIdx);          % Reorder data based on sorted pulses

% Plot each pulse in ascending order
for i = 1:length(sortedPulses)
    pulse = sortedPulses(i);
    data = sortedDataList{i};
    
    % Generate time vector
    time = 1:size(data, 1);
    
    % Plot the data
    plot(time, data, 'LineWidth', 2, ...
         'DisplayName', sprintf('Frequency: %d', pulse));
end

% Customize the plot
xlabel('Time (samples)', 'FontSize', 14);
ylabel(baseName, 'FontSize', 14);
title(sprintf('Plot of %s', Title), 'FontSize', 18);
grid on;

% Show legend only if pulses were detected
if ~isempty(sortedPulses)
    legend('show', 'Location', 'best');
else
    disp('No Pulse variables found in the workspace.');
end

hold off; % Release the plot hold
