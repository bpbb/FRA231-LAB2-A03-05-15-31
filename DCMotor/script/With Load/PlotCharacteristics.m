WNL = 117.29;
INL = 2.5185;
Tl = 0.02;
Tst = 0.22;

for i = 1:1:12
    Pout(i) = (-1 * ((WNL/Tst) * (((i-1)*Tl)^2))) + (WNL * ((i-1)*Tl));
    Pin(i) = ((((CurrentRMS(10)) - INL)/Tl) * (((i-1)*Tl) * 12)) + (INL * 12);

    Eff(i) = (Pout(i) / Pin(i));
end

ax_1 = subplot(2,2,1);
ax_2 = subplot(2,2,2);
ax_3 = subplot(2,2,3);
ax_4 = subplot(2,2,4);

ax = [ax_1;ax_2;ax_3;ax_4];

hold(ax(1),"on");
plot(ax(1), [0,0.22],[WNL,0], '-o', 'MarkerSize', 6, 'LineWidth', 2, 'Color', 'b');
grid(ax(1), 'on');
title(ax(1), 'Plot of Motor Characteristics Torque vs AngleVelocity', 'FontSize', 14);
ylabel(ax(1),'AngleVelocity (rad/s)', 'FontSize', 12);
xlabel(ax(1),"Torque (Nm)", 'FontSize', 12);
hold(ax(1),"off");

hold(ax(2),"on");
plot(ax(2), [0,0.22],[INL,CurrentRMS(10)], '-o', 'MarkerSize', 6, 'LineWidth', 2, 'Color', 'r');
grid(ax(2), 'on');
title(ax(2),'Plot of Motor Characteristics Torque vs Amplitude','FontSize', 14);
ylabel(ax(2),'Current (A)', 'FontSize', 12);
xlabel(ax(2),"Torque (Nm)", 'FontSize', 12);
hold(ax(2),"off");

hold(ax(3),"on");
plot(ax(3), 0:0.02:0.22,Pout, '-o', 'MarkerSize', 6, 'LineWidth', 2, 'Color', 'c');
grid(ax(3), 'on');
title(ax(3),'Plot of Motor Characteristics Torque vs Power', 'FontSize', 14);
ylabel(ax(3),'Pout (W)', 'FontSize', 12);
xlabel(ax(3),"Torque (Nm)", 'FontSize', 12);
hold(ax(3),"off");

hold(ax(4),"on");
plot(ax(4), 0:0.02:0.22,Eff, '-o', 'MarkerSize', 6, 'LineWidth', 2, 'Color', 'm');
grid(ax(4), 'on');
title(ax(4),'Plot of Motor Characteristics Torque vs Efficiency', 'FontSize', 14);
ylabel(ax(4),'N', 'FontSize', 12);
xlabel(ax(4),"Torque (Nm)", 'FontSize', 12);
hold(ax(4),"off");

