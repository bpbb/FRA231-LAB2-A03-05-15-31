% Define the base name and constants (mode and pulse)
baseName = 'Current'; % Replace 'name' with the base name of your variable
mode = 2;          % Replace with your mode value
pwm = 65535;        % Replace with your frequency value
freq = 16;

yunit = '';
if baseName == 'AngVelo'
    yunit = 'Velocity (rad/s)';
end

% Construct the variable name dynamically
varName = sprintf('%s_%d_%d_%d', baseName, mode, pwm, freq);
Title = sprintf('%s Mode : %d PWM : %d Freq : %d', baseName, mode, pwm, freq);

% Check if the variable exists in the workspace
if evalin('base', sprintf('exist(''%s'', ''var'')', varName))
    % Retrieve the variable from the workspace
    data = evalin('base', varName);
    
    % Generate time vector (if not already included in the data)
    time = 1:size(data, 1); % Assuming one row per sample
    
    % Plot the data
    plot(time, data);
    xlabel('Time (ms)');
    ylabel('Amplitude');
    title(sprintf('Plot of %s', Title));
    grid on;
else
    disp('Variable does not exist in the workspace.');
end