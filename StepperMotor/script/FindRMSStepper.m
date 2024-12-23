baseName = 'AngVelo'; 
mode = 6;         
rms = [100 15000 30000];

for i = 1:1:3
    varName = sprintf('%s_%d_%d', baseName, mode, rms(i));
    data = evalin('base', varName);

    AngVelo_6_RMS(i) = sqrt(mean(data(100:1000).^2));
end

