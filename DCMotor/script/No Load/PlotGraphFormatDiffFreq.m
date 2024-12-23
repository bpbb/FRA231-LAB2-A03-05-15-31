% Define the base name and constants (mode and pulse)
baseName = 'Pulse'; % Replace 'Current' with the base name of your variable
mode = 2;             % Replace with your mode value
pwm = 49151;          % Replace with your PWM value
frequencies = [10, 100, 1000, 10000]; % List of different frequencies

% Initialize a figure for the plot
figure;
hold on; % Enable overlaying multiple plots

% Loop through each frequency
for i = 1:length(frequencies)
    freq = frequencies(i); % Current frequency
    
    % Construct the variable name dynamically
    varName = sprintf('%s_%d_%d_%d', baseName, mode, pwm, freq);
    Title = sprintf('%s Mode: %d PWM: %d', baseName, mode, pwm);
    
    % Check if the variable exists in the workspace
    if evalin('base', sprintf('exist(''%s'', ''var'')', varName))
        % Retrieve the variable from the workspace
        data = evalin('base', varName);
        
        % Generate time vector (assuming one row per sample)
        time = 1:size(data, 1);
        
        % Plot the data with a unique color or style for each frequency
        plot(time, data, 'DisplayName', sprintf('Freq: %d Hz', freq));
    else
        disp(['Variable ' varName ' does not exist in the workspace.']);
    end
end

% Customize the plot
xlabel('Time (samples)');
ylabel('Amplitude');
title(sprintf('Plot of %s', Title));
legend('show', 'Location', 'best'); % Show legend with frequency labels
grid on;
hold off; % Release the plot hold
