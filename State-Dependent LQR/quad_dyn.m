function dx = quad_dyn(t,y,params)

global uu 
p = reshape(y(1:3),[3 1])
q = reshape(y(4:7),[4 1]);
v = reshape(y(8:10),[3 1]);
prevu = reshape(uu(end,:),[4 1]);

u = quad_sdlqr(t,y,params,prevu)
wn = reshape(u(1:3),[3 1]);
cn = [0;0;u(4)];
dp = double(v);
dq = double(0.5*quat_mult(q)*[0;wn])
dv = double([0;0;-params.g] + quat_rot(q)*cn)

dx = [dp;dq;dv];


end