dat = load('demo_data.mat');

params.m = 4.34;
params.g = 9.98;
params.d = 0.315;
params.ctf = 8.004*10e-4;
params.J = diag([0.0820,0.0845,0.1377]);
params.kx = 16*params.m;
params.kv = 5.6*params.m;
params.kr = 8.81;
params.kw = 2.54;
params.e1 = [1;0;0];
params.e2 = [0;1;0];
params.e3 = [0;0;1];
params.T = [1,1,1,1;0,-params.d,0,params.d;params.d,0,-params.d,0;-params.ctf,params.ctf,-params.ctf,params.ctf];

t = dat.data(:,1);
y = dat.data(:,2:11);

quad_plotcom(t,y,params);