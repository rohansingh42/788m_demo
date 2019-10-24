function quad_animate(t,y,params)

k = 0;

vq = interp1(t,y,[0:0.05:4]')
[m n] = size(vq)

for i = 1 : m
    x = vq(i,1:3);
    v = vq(i,4:6);
    W = vq(i,7:9);
    R = [vq(i,10:12);vq(i,13:15);vq(i,16:18)];
    
    r1 = (x' + params.d*R*params.e1)';
    r2 = (x' - params.d*R*params.e1)';
    r3 = (x' + params.d*R*params.e2)';
    r4 = (x' - params.d*R*params.e2)';
    R
    r5 = (x' + params.d*R*params.e3)';
    
    figure(2)
    plot3(vq(:,1),vq(:,2),vq(:,3),':');
    hold on;
    plot3([x(1);r1(1)],[x(2);r1(2)],[x(3);r1(3)]);
    hold on;
    plot3([x(1);r2(1)],[x(2);r2(2)],[x(3);r2(3)]);
    hold on;
    plot3([x(1);r3(1)],[x(2);r3(2)],[x(3);r3(3)]);
    hold on;
    plot3([x(1);r4(1)],[x(2);r4(2)],[x(3);r4(3)]);
    hold on;
    plot3([x(1);r5(1)],[x(2);r5(2)],[x(3);r5(3)]);
    hold on;
    plot3(r1(1),r1(2),r1(3),'o');
    hold on;
    plot3(r2(1),r2(2),r2(3),'o');
    hold on;
    plot3(r3(1),r3(2),r3(3),'o');
    hold on;
    plot3(r4(1),r4(2),r4(3),'o');
    hold on;
    plot3(r5(1),r5(2),r5(3),'^');
    hold on;
    grid on;
    axis([-2 2 -2 2 -2 2]);
    axis on;
    drawnow
%     pause(0.5)
    hold off;
end

end
