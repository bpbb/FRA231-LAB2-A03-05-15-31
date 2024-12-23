baseName = 'Current';
mode = 2;
pwm = 65535;

for i = 1:1:10
    varName = sprintf('%s_%d_%d_%d', baseName, 2, 65535, i*2);
    data = evalin('base', varName);

    CurrentRMS(i) = sqrt(mean(data(101:1001).^2));
end

baseName = 'AngVelo';
mode = 2;          
pwm = 65535;        

for i = 1:1:10
    varName = sprintf('%s_%d_%d_%d', baseName, 2, 65535, i*2);
    data = evalin('base', varName);

    AngVeloRMS(i) = sqrt(mean(data(101:1001).^2));
end

