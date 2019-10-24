clear all
digits(3)
global iter
global tt yy uu

params.g = 10;
params.Q = diag([100,100,100,1,1,1,1,10,10,10]);
params.R = diag([1,5,5,0.1]);

params.u0 = [0.0;0.0;10;10];
params.x0 = [1.5;1.5;0.5;1;0;0;0;0;0;0];

uu = [params.u0.'];

y0 = params.x0;
dyn = @(t,y)quad_dyn(t,y,params);uu
op = @(t,y,flag)idlk(t,y,flag,params);
options = odeset('OutputFcn',op);

[t,y] = ode45(dyn,[0 30],y0,options);