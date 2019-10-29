
clear all;

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

syms a
params.xd = [0.4*a; 0.4*sin(pi*a); 0.6*cos(pi*a)];
% params.xd = [0;0;0];
params.dxd = diff(params.xd,1);
params.ddxd = diff(params.xd,2);
params.d3xd = diff(params.xd,3);
params.d4xd = diff(params.xd,4);
params.b1d = [cos(pi*a);sin(pi*a);0];
% params.b1d = [1;0;0];
params.db1d = diff(params.b1d,1);
params.ddb1d = diff(params.b1d,2);

% dat = load('case1_data.mat');
dat = load('case3_data.mat');

% quad_plot(dat.data(:,1),dat.data(:,2:19),params);

quad_animate(dat.data(:,1),dat.data(:,2:19),params);


