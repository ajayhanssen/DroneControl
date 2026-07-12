syms phi theta psi phi_d theta_d psi_d real

mat = [1 sin(phi)*tan(theta) cos(phi)*tan(theta)
       0 cos(phi) -sin(phi)
       0 sin(phi)/cos(theta) cos(phi)/cos(theta)]

invmat = inv(mat)

invmat = [1,     0,      -cos(theta)*tan(theta)
          0,  cos(phi),   cos(theta)*sin(phi)
          0, -sin(phi),   cos(phi)*cos(theta)]

pqr_sym = invmat*[phi_d theta_d psi_d]'
pqr_sym_lin = subs(pqr_sym, [phi, psi, theta], [0 0 0])

pqr_sim = [phi_d - sin(theta) * psi_d
           cos(phi) * theta_d + sin(phi) * cos(theta) * psi_d
          -sin(phi) * theta_d + cos(phi) * cos(theta) * psi_d]
pqr_sim_lin = subs(pqr_sim, [phi, psi, theta], [0 0 0])