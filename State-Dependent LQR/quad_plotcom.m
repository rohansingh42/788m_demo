function quad_plotcom(t,y,params)

k = 0;
vq = y;
[m n] = size(vq)

gt = [0,0,0.5; 0,0,1; 1,0,1; 1,1,1; 0,1,1; 0,0,1];

figure(2)
plot3(vq(:,1),vq(:,2),vq(:,3),'o');
hold on;
plot3(gt(:,1),gt(:,2),gt(:,3),'-')
grid on;
axis([-2 2 -2 2 0 2]);
axis on;
drawnow

end
