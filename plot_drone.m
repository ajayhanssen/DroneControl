outvar = out.simout1;

t = outvar.Time;
x = outvar.Data(1,:,:);
x = reshape(x, [], 1);
y = outvar.Data(2,:,:);
y = reshape(y, [], 1);
z = outvar.Data(3,:,:);
z = reshape(z, [], 1);
phi = outvar.Data(7,:,:);
theta = outvar.Data(8,:,:);
psi = outvar.Data(9,:,:);

TR = stlread("drohne_model.stl");

figure()
h = patch('Faces', TR.ConnectivityList, 'Vertices', TR.Points, 'FaceColor', 'cyan');
axis equal
grid on
view([45 45])

tform = hgtransform;
set(h, 'Parent', tform);
xlim([min(y)-1 max(y)+1])
ylim([min(x)-1 max(x)+1])
zlim([-3 3])
xlabel('x'); ylabel('y'); zlabel('z');

hold on
flownPath = animatedline('Color', 'r', 'LineWidth', 1.5, 'LineStyle', '-');

% bei NED: x=y, y=x, z=-z
C = [0 1 0;
     1 0 0;
     0 0 -1];

for i = 1:length(t)
    if mod(i,2) == 0

        % pos conv
        % drecks NED 2 ENU
        pos = [y(i); x(i); -z(i)];

        addpoints(flownPath, pos(1), pos(2), pos(3));

        % rot conv
        R_ned = eul2rotm([psi(i), theta(i), phi(i)], 'ZYX');
        R = C * R_ned * C';

        % transform mat
        T = eye(4);
        T(1:3,1:3) = R;
        T(1:3,4) = pos;

        set(tform, 'Matrix', T);

        drawnow
        if i > 1
            pause(t(i)-t(i-1))
        end
    end

end
