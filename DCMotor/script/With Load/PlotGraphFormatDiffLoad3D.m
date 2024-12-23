baseName = 'Pulse';
mode = 2;             
pwm = 65535;          
loads = 2:2:22;

% Initialize a figure for the 3D plot
figure;
hold on; % Enable overlaying multiple plots for 3D data

% Loop through each load
for i = 1:length(loads)
    load = loads(i); % Current load
    
    % Construct the variable name dynamically
    varName = sprintf('%s_%d_%d_%d', baseName, mode, pwm, load);
    Title = sprintf('%s Mode: %d PWM: %d', baseName, mode, pwm);
    
    % Check if the variable exists in the workspace
    if evalin('base', sprintf('exist(''%s'', ''var'')', varName))
        % Retrieve the variable from the workspace
        data = evalin('base', varName);
        
        % Generate time vector (assuming one row per sample)
        time = 1:size(data, 1);
        
        % Map load index to a normalized index for uniform spacing
        loadIndex = i; % Sequential indices (1, 2, 3, ...)
        
        % Create a load vector with the normalized index
        loadVector = loadIndex * ones(size(data, 1), 1);
        
        % Plot the 3D data
        plot3(time, loadVector, data, 'LineWidth', 1.5, ...
              'DisplayName', sprintf('%.2f Nm', load / 100)); % Convert to Nm for legend
    else
        disp(['Variable ' varName ' does not exist in the workspace.']);
    end
end

% Customize the 3D plot
xlabel('Time (samples)','FontSize',16);
ylabel('Load Index','FontSize',16);
zlabel('Pulses','FontSize',16);
title(sprintf('3D Plot of %s', Title),'FontSize',18);

% Adjust the Y-axis ticks and labels
yticks(1:length(loads)); % Use normalized indices
yticklabels(arrayfun(@(x) sprintf('%.2f Nm', x / 100), loads, 'UniformOutput', false)); 
% Use scaled load values in Nm

legend('show', 'Location', 'best'); % Show legend with load labels
grid on;
view(45, 30); % Adjust the viewing angle for better visibility
hold off; % Release the plot hold

