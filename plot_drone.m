t = out.simout.Time;
x = out.simout.Data(1,:,:);
y = out.simout.Data(2,:,:);
z = out.simout.Data(3,:,:);
phi = out.simout.Data(7,:,:);
theta = out.simout.Data(8,:,:);
psi = out.simout.Data(9,:,:);

TR = stlread("drohne_model.stl");

figure()
h = patch('Faces', TR.ConnectivityList, 'Vertices', TR.Points, 'FaceColor', 'cyan');
axis equal
grid on
view([45 45])

tform = hgtransform;
set(h, 'Parent', tform);
xlim([-2 2])
ylim([-2 2])
zlim([-2 2])
xlabel('x'); ylabel('y'); zlabel('z');

% bei NED: x=y, y=x, z=-z
C = [0 1 0;
     1 0 0;
     0 0 -1];

for i = 1:length(t)
    if mod(i,2) == 0

        % pos conv
        % drecks NED 2 ENU
        pos = [y(i); x(i); -z(i)];

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
