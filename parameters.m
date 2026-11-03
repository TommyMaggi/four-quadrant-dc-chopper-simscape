% Parameters for four_quadrant_chopper.slx
% Run this script before opening/simulating the model.
clc;
close all;
clear all;

%% DC motor data (datasheet)
Vn  = 12;          % V      nominal voltage
vnl = 6920;        % rpm    no-load speed
Inl = 0.241;       % A      no-load current
vn  = 6370;        % rpm    nominal speed
Cn  = 0.095;       % Nm     nominal torque
In  = 6.000;       % A      nominal current
Cs  = 0.1680;      % Nm     stall torque
Is  = 102;         % A      starting (stall) current
R   = 0.12;        % Ohm    winding resistance
L   = 0.000025;    % H      winding inductance
kt  = 0.0164;      % Nm/A   torque constant
ks  = 581;         % rpm/V  speed constant
Jr  = 0.0000139;   % kg m^2 rotor inertia

%% Mechanical load (torque proportional to speed)
slt = 0.00002848;  % Nms    load torque slope
Jl  = 0.0000209;   % kg m^2 load inertia

%% Supply (battery)
V   = 15;          % V      supply voltage
Rv  = 0.15;        % Ohm    source internal resistance
Lv  = 0.00015;     % H      source internal inductance

%% Converter (4-quadrant DC/DC)
Imax = 9.0;        % A      max. output current

%% Derived quantities
J  = Jl + Jr;      % kg m^2 total inertia
kw = ks*30/pi;     % speed constant in (rad/s)/V

%% Tunable parameters
fsw = 100000;      % Hz     PWM switching frequency
Ri  = 0.1;         % speed PI, integral gain
Rp  = 0.02;        % speed PI, proportional gain
Rii = 1000;        % current PI, integral gain
Rpi = 50;          % current PI, proportional gain

%% Speed reference profile (per-unit of nominal speed, repeating sequence)
% time [s] / speed [p.u.] pairs
time  = [0 0.1 0.10001 0.3 0.30001 0.4 0.40001 0.6 0.60001 0.8 0.80001 0.99999 1];
value = [0 0   1.25    1.25 -0.5   -0.5 0.25   0.25 0.5    0.5 1.25    1.25    0];
period_duty = max(time);
