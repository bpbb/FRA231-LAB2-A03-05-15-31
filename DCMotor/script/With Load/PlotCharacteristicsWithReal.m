WNL = 117.29;
INL = 2.5185;

ax_1 = subplot(2,1,1);
ax_2 = subplot(2,1,2);

ax = [ax_1;ax_2];

hold(ax(1),"on");
plot(ax(1), [0,0.2],[WNL,0], '-o', 'MarkerSize', 6, 'LineWidth', 2, 'Color', 'b');
plot(ax(1), 0.02:0.02:0.2, AngVeloRMS, '-o', 'MarkerSize', 6, 'LineWidth', 2, 'Color', 'r');
grid(ax(1), 'on');
title(ax(1), 'Plot of Motor Characteristics Torque vs AngleVelocity', 'FontSize', 14);
ylabel(ax(1),'Angle Velocity (rad/s)', 'FontSize', 12);
xlabel(ax(1),"Torque (Nm)", 'FontSize', 12);
legend(ax(1),'Ideal','Real');
hold(ax(1),"off");

hold(ax(2),"on");
plot(ax(2), [0,0.2],[INL,CurrentRMS(10)], '-o', 'MarkerSize', 6, 'LineWidth', 2, 'Color', 'b');
plot(ax(2), 0.02:0.02:0.2, CurrentRMS, '-o', 'MarkerSize', 6, 'LineWidth', 2, 'Color', 'r');
grid(ax(2), 'on');
title(ax(2),'Plot of Motor Characteristics Torque vs Amplitude','FontSize', 14);
ylabel(ax(2),'Current (A)', 'FontSize', 12);
xlabel(ax(2),"Torque (Nm)", 'FontSize', 12);
legend(ax(2),'Ideal','Real');
hold(ax(2),"off");

