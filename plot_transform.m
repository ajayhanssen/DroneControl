t = out.simout.Time;
x = out.simout.Data(1,:,:);
y = out.simout.Data(3,:,:);
z = out.simout.Data(5,:,:);
phi = out.simout.Data(7,:,:);
theta = out.simout.Data(9,:,:);
psi = out.simout.Data(11,:,:);

axes( 'DataAspectRatio', [1 1 1], 'View', [37.5 30] )
for i = 1:length(x)
    plotframe( eye(3))
    rot = eul2rotm([phi(i), theta(i), psi(i)], 'XYZ');
    trans = [x(i), y(i), z(i)];
    hold on
    plotframe( rot, trans )
end

grid on
%xlim([-5 5])
%ylim([-5 5])
%zlim([0 10])