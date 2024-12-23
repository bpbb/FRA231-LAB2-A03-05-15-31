% Define the base name and constants (mode, frequency, and PWM values)
baseName = 'Pulse'; % Replace 'Pulse' with the base name of your variable
mode = 2;           % Replace with your mode value
freq = 10000;        % Set a single frequency value
pwms = [1, 16383, 32767, 49151, 65535]; % List of different PWM values

% Initialize a figure for the plot
figure;
hold on; % Enable overlaying multiple plots

% Loop through each PWM value
for p = 1:length(pwms)
    pwm = pwms(p); % Current PWM value

    % Construct the variable name dynamically
    varName = sprintf('%s_%d_%d_%d', baseName, mode, pwm, freq);
    Title = sprintf('%s Mode: %d Freq: %d Hz', baseName, mode, freq);
    
    % Check if the variable exists in the workspace
    if evalin('base', sprintf('exist(''%s'', ''var'')', varName))
        % Retrieve the variable from the workspace
        data = evalin('base', varName);

        % Generate time vector (assuming one row per sample)
        time = 1:size(data, 1);

        % Plot the data with a unique color or style for each PWM value
        plot(time, data, 'DisplayName', sprintf('PWM: %d', pwm));
    else
        disp(['Variable ' varName ' does not exist in the workspace.']);
    end
end

% Customize the plot
xlabel('Time (samples)');
ylabel('Amplitude');
title(sprintf('Plot of %s', Title));
legend('show', 'Location', 'best'); % Show legend with PWM labels
grid on;
hold off; % Release the plot hold
