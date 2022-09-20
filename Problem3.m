clc
clear
% Edit this line and look for changes
%% Define Variables
m=2.5; %kg
y0 = 1; %m
x0 = 0; 
g = 9.81;
la= 45*pi/180; %m
Cx=0.4; % coefficeint of drag
vw=3 %m/s
v=30;
vx=v*cos(la);
vy=v*sin(la);

% Set Parameters for Forcing Function
Ts = 10;         % Step time [s]
Fs = 100;         % Final step value (N)

% Parameters for Fixed-Step ODE1 Solver
Tf = 2.9;       % Simulation end time
T_step = 0.1;   % Step size

%% Simulation
opt = simset('Solver','ODE1','FixedStep',T_step); 
%opt = simset('Solver','ODE45'); 
sim('symproblem3',Tf,opt);
plot(ans.x,ans.y)
xlabel("Distance (m)")
ylabel("Height (m)")
title("Chicken Flight Map")