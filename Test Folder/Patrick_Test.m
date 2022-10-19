%% Practice making plots
x=(-100:1:100);
y=4*x.^2-4;
y1=x*log(10);
y2=-x.^3-5*x.^2+x*50+3;

%% Create Plots for y, y1, y2
% Make on with subplots of indiviual figures,  make one combined graph with
% a legeng. Also Include titles, line size, line color, and axis title. 


figure
plot(x,y, "LineWidth",2, "color", 'r')
ylim([-100 100])
xlim([-100 100])
hold on
grid on
plot(x,y1, "LineWidth",2, "color", 'b')
plot(x,y2, "LineWidth",2, "color", 'k')
title("Practice Plot")
xlabel("time(S)")
ylabel('height [m]')
legend("y",'y1','y2')
