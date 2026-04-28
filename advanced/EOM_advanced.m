syms phi theta psi real

R_psi = [ cos(psi)  sin(psi)  0
         -sin(psi)  cos(psi)  0
             0         0      1];

R_theta = [ cos(theta)  0  -sin(theta)
    	        0       1       0
            sin(theta)  0   cos(theta)];

R_phi = [1     0         0
         0  cos(phi)  sin(phi)
         0 -sin(phi)  cos(phi)];

R_rate = [1  sin(phi)*tan(theta) cos(phi)*tan(theta)
          0        cos(phi)           -sin(phi)
          0  sin(phi)/cos(theta) cos(phi)/cos(theta)];        % differentiated rotation matrix apparently

R_rate_dot = diff(R_rate, phi)*phi_d + diff(R_rate, theta)*theta_d;

R_G_b = R_phi*R_theta*R_psi;

R_b_G = R_G_b';

%% EOM
syms X_d X_dd Y_d Y_dd Z_d Z_dd x_d x_dd y_d y_dd z_d z_dd real
syms phi_d phi_dd theta_d theta_dd psi_d psi_dd real
syms p q r real
syms m g I_xx I_yy I_zz J_r l w1 w2 w3 w4 K_T K_d_t K_d real

U1 = K_T*(w1^2+w2^2+w3^2+w4^2);
tau_phi = l*K_T*(w4^2-w2^2);
tau_theta = l*K_T*(w1^2-w3^2);
tau_psi = K_d*(w1^2-w2^2+w3^2-w4^2);

F_d = K_d_t*eye(3) * [X_d Y_d Z_d]' % drag force

F_T = R_b_G * [0 0 U1]'     % vertical thrust in global coordinates, rotate with matrix

F_G = [0 0 m*g]



% translational EOM in global coordinates!
T_d = [X_d Y_d Z_d]' == R_b_G * [x_d y_d z_d]'

T_dd = [X_dd Y_dd Z_dd]' == 1/m * (F_G' - F_T - F_d)



% rotational EOM on local coordinates

w = [phi_d theta_d psi_d]';
w_b = [p q r]'

I = [I_xx 0 0
     0 I_yy 0
     0 0 I_zz];

tau_m = [tau_phi tau_theta tau_psi]';

tau_g = [J_r*theta_d*(w1-w2+w3-w4)
        -J_r*phi_d*(w1-w2+w3-w4)
                    0           ];

w_b_d = inv(I)* (tau_m - tau_g - cross(w_b, I*w_b));

R_d = [phi_d theta_d psi_d]' == R_rate * w_b

R_dd = [phi_dd theta_dd psi_dd]' == R_rate_dot * w_b + R_rate * w_b_d