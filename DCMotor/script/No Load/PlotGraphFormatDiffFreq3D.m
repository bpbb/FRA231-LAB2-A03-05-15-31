baseName = 'Current';
mode = 2;             
pwm = 65535;          
frequencies = [10, 100, 1000, 10000]; % List of different frequencies

% Initialize a figure for the 3D plot
figure;
hold on; % Enable overlaying multiple plots for 3D data

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
        
        % Map frequency to a normalized index for uniform spacing
        freqIndex = i; % Sequential indices (1, 2, 3, 4)
        
        % Create a frequency vector with the normalized index
        freqVector = freqIndex * ones(size(data, 1), 1);
        
        % Plot the 3D data
        plot3(time, freqVector, data, 'LineWidth', 1.5, ...
              'DisplayName', sprintf('Freq: %d Hz', freq));
    else
        disp(['Variable ' varName ' does not exist in the workspace.']);
    end
end

% Customize the 3D plot
xlabel('Time (samples)','FontSize',16);
ylabel('Frequency','FontSize',16);
zlabel('Angular Velocity (rad/s)','FontSize',16);
title(sprintf('3D Plot of %s', Title),'FontSize',18);

% Adjust the Y-axis ticks and labels
yticks(1:length(frequencies)); % Use normalized indices
yticklabels(arrayfun(@num2str, frequencies, 'UniformOutput', false)); % Use actual frequency values

legend('show', 'Location', 'best'); % Show legend with frequency labels
grid on;
view(45, 30); % Adjust the viewing angle for better visibility
hold off; % Release the plot hold
