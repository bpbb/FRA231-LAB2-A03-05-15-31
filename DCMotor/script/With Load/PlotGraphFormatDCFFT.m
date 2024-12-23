baseName = 'AngVelo';
mode = 2;     
pwm = 65535;  
loads = 2:2:22;    

% Define Y-axis unit based on the baseName
yunit = '';
if strcmp(baseName, 'AngVelo') % Use strcmp for string comparison
    yunit = 'Velocity (rad/s)';
    signalType = 'Angular Velocity';
else
    yunit = 'Amplitude'; % Default unit
    signalType = 'Current'; % Set signal type for current
end

% Loop through each load
for load = loads
    % Construct the variable name dynamically
    varName = sprintf('%s_%d_%d_%d', baseName, mode, pwm, load);
    formattedLoad = load / 100; % Convert load to fractional value
    Title = sprintf('%s Mode: %d PWM: %d Load: %.2f Nm', signalType, mode, pwm, formattedLoad);

    % Check if the variable exists in the workspace
    if evalin('base', sprintf('exist(''%s'', ''var'')', varName))
        % Retrieve the variable from the workspace
        data = evalin('base', varName);
        
        % Generate time vector (assuming 1 sample = 1 centisecond)
        time = (0:size(data, 1) - 1) * 0.01; % Time vector in seconds (centiseconds)

        % Create a figure for each load
        figure;

        % Plot original data
        subplot(1, 2, 1);
        plot(time, data, 'LineWidth', 1.5);
        xlabel('Time (s)');
        ylabel(yunit);
        title(sprintf('%s (Load: %.2f Nm)', signalType, formattedLoad));
        grid on;

        % FFT of the data
        L = length(data);            % Length of the signal
        Fs = 100;                    % Sampling frequency in Hz (centiseconds = 100 Hz)
        f = Fs * (0:(L/2)) / L;      % Frequency vector (one-sided)
        Y = fft(data);               % Compute FFT
        P2 = abs(Y / L);             % Two-sided spectrum
        P1 = P2(1:L/2+1);            % Single-sided spectrum
        P1(2:end-1) = 2 * P1(2:end-1); % Adjust for single-sided spectrum

        % Plot the FFT
        subplot(1, 2, 2);
        plot(f, P1, 'LineWidth', 1.5);
        xlabel('Frequency (Hz)');
        ylabel('|Amplitude|');
        title(sprintf('FFT of %s (Load: %.2f Nm)', signalType, formattedLoad));
        grid on;

    else
        disp(['Variable ' varName ' does not exist in the workspace.']);
    end
end

