t = out.simout.Time;
x = out.simout.Data(:,1);
y = out.simout.Data(:,2);
z = out.simout.Data(:,3);
phi = out.simout.Data(:,7);
theta = out.simout.Data(:,8);
psi = out.simout.Data(:,9);

axes( 'DataAspectRatio', [1 1 1], 'View', [37.5 30] )
for i = 1:length(x)
    plotframe( eye(3))
    rot = eul2rotm([phi(i), theta(i), psi(i)], 'XYZ');
    trans = [x(i), y(i), z(i)];
    hold on
    if mod(i, 10)==0
        plotframe( rot, trans )
    end
end

grid on
%xlim([-5 5])
%ylim([-5 5])
%zlim([0 10])