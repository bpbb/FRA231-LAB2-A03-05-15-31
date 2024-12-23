% Define the base name and constants (mode and pulse)
baseName = 'Current'; % Replace 'name' with the base name of your variable
mode = 2;             % Replace with your mode value
pwm = 65535;          % Replace with your frequency value
freq = 10000;

yunit = '';
if strcmp(baseName, 'AngVelo') % Use strcmp for string comparison
    yunit = 'Velocity (rad/s)';
end

% Construct the variable name dynamically
varName = sprintf('%s_%d_%d_%d', baseName, mode, pwm, freq);
Title = sprintf('%s Mode : %d PWM : %d Freq : %d', baseName, mode, pwm, freq);

% Check if the variable exists in the workspace
if evalin('base', sprintf('exist(''%s'', ''var'')', varName))
    % Retrieve the variable from the workspace
    data = evalin('base', varName);
    
    % Generate time vector (assuming 1 sample per millisecond)
    time = (0:size(data, 1) - 1); % Time vector in ms

    % Plot original data
    figure;
    subplot(2, 2, 1);
    plot(time, data);
    xlabel('Time (ms)');
    ylabel(yunit);
    title('Original Signal');
    grid on;

    % FFT of the data
    L = length(data);            % Length of the signal
    Fs = 1000;                   % Sampling frequency in Hz (adjust as needed)
    f = Fs * (0:(L/2)) / L;      % Frequency vector (one-sided)
    Y = fft(data);               % Compute FFT
    P2 = abs(Y / L);             % Two-sided spectrum
    P1 = P2(1:L/2+1);            % Single-sided spectrum
    P1(2:end-1) = 2 * P1(2:end-1); % Adjust for single-sided spectrum

    % Plot the FFT
    subplot(2, 2, 2);
    plot(f, P1);
    xlabel('Frequency (Hz)');
    ylabel('|Amplitude|');
    title('FFT of the Signal');
    grid on;

    % Low-pass filter design (adjust the cutoff frequency as needed)
    cutoff = 50; % Low-pass filter cutoff frequency in Hz
    [b, a] = butter(4, cutoff / (Fs / 2), 'low'); % 4th-order Butterworth filter

    % Apply the low-pass filter to the data
    filteredData = filtfilt(b, a, data);

    % Plot filtered data
    subplot(2, 2, 3);
    plot(time, filteredData);
    xlabel('Time (ms)');
    ylabel(yunit);
    title('Filtered Signal (Low-pass)');
    grid on;

    % FFT of the filtered data
    Y_filtered = fft(filteredData);   % Compute FFT of the filtered signal
    P2_filtered = abs(Y_filtered / L);
    P1_filtered = P2_filtered(1:L/2+1);
    P1_filtered(2:end-1) = 2 * P1_filtered(2:end-1);

    % Plot the FFT of the filtered signal
    subplot(2, 2, 4);
    plot(f, P1_filtered);
    xlabel('Frequency (Hz)');
    ylabel('|Amplitude|');
    title('FFT of Filtered Signal');
    grid on;

else
    disp('Variable does not exist in the workspace.');
end
