baseName = 'Current'; 
mode = 2;       
freq = 100;     
pwms = [1, 16383, 32767, 49151, 65535]; 

% Initialize a figure for the 3D plot
figure;
hold on; % Enable overlaying multiple plots for 3D data

% Loop through each PWM
for i = 1:length(pwms)
    pwm = pwms(i);
    
    % Construct the variable name dynamically
    varName = sprintf('%s_%d_%d_%d', baseName, mode, pwm, freq);
    Title = sprintf('%s Mode: %d Frequency: %d Hz', baseName, mode, freq);
    
    % Check if the variable exists in the workspace
    if evalin('base', sprintf('exist(''%s'', ''var'')', varName))
        % Retrieve the variable from the workspace
        data = evalin('base', varName);
        
        % Generate time vector (assuming one row per sample)
        time = 1:size(data, 1);
        
        % Map PWM to a normalized index for uniform spacing
        pwmIndex = i; % Sequential indices (1, 2, 3, 4)
        
        % Create a PWM vector with the normalized index
        pwmVector = pwmIndex * ones(size(data, 1), 1);
        
        % Plot the 3D data
        plot3(time, pwmVector, data, 'LineWidth', 1.5, ...
              'DisplayName', sprintf('PWM: %d', pwm));
    else
        disp(['Variable ' varName ' does not exist in the workspace.']);
    end
end

% Customize the 3D plot
xlabel('Time (samples)','FontSize',16);
ylabel('PWM','FontSize',16);
zlabel('Angular Velocity (rad/s)','FontSize',16);
title(sprintf('3D Plot of %s', Title),'FontSize',18);

% Adjust the Y-axis ticks and labels
yticks(1:length(pwms)); % Use normalized indices
yticklabels(arrayfun(@num2str, pwms, 'UniformOutput', false)); % Use actual PWM values

legend('show', 'Location', 'best'); % Show legend with PWM labels
grid on;
view(45, 30); % Adjust the viewing angle for better visibility
hold off; % Release the plot hold

