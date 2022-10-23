%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ME-5339 Simulation Techniques for Dynamic Systems Analysis and Design
% M. Canova, S. Stockar, Autumn 2022
%
% Lab 6: Cruise Control Problem
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc

%% Define Model Parameters
g       = 9.81;  % [m/s^2]
rho     = 1.2;   % [kg/m^3]
M_veh   = 2400;  % Vehicle Mass
M_eq    = 200;   % Equivalent mass for rotating inertias [kg]
M_tot   = M_veh + M_eq;
Cd      = 0.52; % Drag Coefficient
Af      = 12;   % [m^2] Frontal Area
% Rolling Resistance Parameters
a       = 0.03;
b       = 0.001;
Vstep=10;

%% Define Simulation Parameters and load model inputs
load roadGradeLookup.mat
% Select case: 0 - flat road, 1 - hilly terrain
gradeFlag = 1;

% Initialize Traction Force
F0 = 3500;  % [Nm]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Design FF Controller
V_FF=0:5:40; %m/s refrence input speed for FF control
F_FF = 0.5*rho*Cd*Af*V_FF.^2+(a+b*V_FF)*g*M_veh; % Assume it has 0 grade

% figure
% plot(V_FF,F_FF,'linewidth',2)
% grid on
% hold on
% xlabel('Refrence Speed [m/s]')
% ylabel('Feed-Foward Component [kNm]')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Run Simulation
Tend = 10*60;
V0  = 25.5; % Initial Velocity [m/s] (57mph)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Design FB Controller
V0=25.5;
F0=1/2*rho*Cd*Af*V0^.2;
A=-(rho*Cd*Af*V0+b*M_veh*g)/M_tot;
B=1/M_tot;
C=1;
D=0;
sys= ss(A,B,C,D);
Kp=1000;
ki=150;
kd=0;
ctr=pid(Kp,ki,kd);
T = feedback(sys,ctr);
% figure
% step(sys)
% hold all
% step(T)

out = sim('cruiseControlModel2018b',Tend);
figure
subplot(311)
plot(out.tout,out.alpha/pi*180);
grid on
set(gca,'xticklabel',[],'ylim',[-5 5]);
ylabel('Grade [deg]');
subplot(312)
plot(out.tout,out.u/1000);
grid on
hold on
plot(out.tout,out.u_FB/1000);
set(gca,'xticklabel',[],'ylim',[0 20]);
ylabel('Traction Force [kNm]');
subplot(313)
plot(out.tsim,out.V_Veh);
grid on
hold on
set(gca,'ylim',[0 40]);
plot(out.tsim,out.V_ref,'r');
xlabel('Time [s]')
ylabel('Veh. Speed [m/s]');