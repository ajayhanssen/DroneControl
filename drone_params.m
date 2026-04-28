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

K_dx = 0;
K_dy = 0;
K_dz = 0;
% b = 6.317e-4;
% d = 1.61e-4;

%% ss model
T = 0.02;       % sampling time

load('linearized_model.mat')
A_num_c = double(subs(A_lin, [m_sym g_sym l_sym I_xx_sym I_yy_sym I_zz_sym], ...
                             [m g l I_xx I_yy I_zz]));

B_num_c = double(subs(B_lin, [m_sym g_sym l_sym I_xx_sym I_yy_sym I_zz_sym], ...
                             [m g l I_xx I_yy I_zz]));

C_num = eye(12);
D_num = 0;

% state spüace
sys_c = ss(A_num_c, B_num_c, C_num, D_num);
sys_d = c2d(sys_c, T);

% Controllability
