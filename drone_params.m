m = 0.568;          % kg
g = 9.81;           % m/s^2
l = 0.2;            % m

% Inertia tensor drone
I_xx = 5144.434e-6;     % kgm^2
I_yy = 5144.434e-6;     % kgm^2
I_zz = 10289.036e-6;    % kgm^2

% Inertia motor
J_r = 15e-6;           % kgm^2

C_T = 0.121;            % thrust coeffieicnt
C_p = 0.0495;           % power coefficient
rho_A = 1.255;          % air density
D = 0.15;                % blade diameter

b = C_T*rho_A*D^4;            % thrust factor
d = C_p*rho_A*D^5;            % drag factor

% b = 6.317e-4;
% d = 1.61e-4;
%% MPC
