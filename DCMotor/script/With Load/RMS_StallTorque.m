array = [];
for i = 1:length(StallTorque_2_65535_1000)
    if StallTorque_2_65535_1000(i) > 0
        array(end+1) = StallTorque_2_65535_1000(i);
    end
end

rmsValue = sqrt(mean(array.^2));

