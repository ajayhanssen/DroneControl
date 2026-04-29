t = out.simout.Time;
x = out.simout.Data(:,1);
y = out.simout.Data(:,2);
z = out.simout.Data(:,3);
phi = out.simout.Data(:,7);
theta = out.simout.Data(:,8);
psi = out.simout.Data(:,9);

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
zlim([0 4])

for i =1:length(t)
    if mod(i, 5) == 0
        R = eul2rotm([phi(i), theta(i), psi(i)], 'XYZ');
    
        % Homogeneous transform
        T = eye(4);
        T(1:3,1:3) = R;
        T(1:3,4) = [x(i); y(i); z(i)];
    
        % Apply transform
        set(tform, 'Matrix', T);
    
        drawnow
        if i > 1
            pause(t(i)-t(i-1))
        end
    end

end