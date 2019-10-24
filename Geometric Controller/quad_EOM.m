function dy = quad_EOM(t,y,params)

x = y(1:3);
v = y(4:6);
W = y(7:9);
R = [y(10:12)';y(13:15)';y(16:18)'];

c = control(t,y,params); 
f = c(1);
M = c(2:4);

dx = v;
dv = params.g*params.e3 - (1/params.m)*f*R*params.e3;
dW = (params.J)\(M - cross(W,params.J*W));
% cross(W,params.J*W)
dR = R*hat(W);

dy = [dx',dv',dW',dR(1,:),dR(2,:),dR(3,:)]';

end