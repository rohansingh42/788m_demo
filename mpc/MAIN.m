clear all;
nx = 13;
ny = 13;
nu = 4;
nlobj = nlmpc(nx, ny, nu);
Ts = 0.1;
nlobj.Ts = Ts;
nlobj.PredictionHorizon = 20;
nlobj.ControlHorizon = 5;

statefcn = @(x,u)(autoGen_dyn_B_com(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),x(9),x(10),x(11),x(12),x(13),u(1),u(2),u(3),u(4)));
statejacfcn = @(x,u)jacobian_wrapper_B_com(x,u);
                 
nlobj.Model.StateFcn = statefcn;
nlobj.Jacobian.StateFcn = statejacfcn;

nlobj.Model.IsContinuousTime = true;

% nlobj.States(1).Min = -10;
% nlobj.States(2).Min = -10;
% nlobj.States(3).Min = 0.4;
% nlobj.States(4).Min = -10;
% nlobj.States(5).Min = -10;
% nlobj.States(6).Min = -10;
% nlobj.States(7).Min = -1;
% nlobj.States(8).Min = -1;
% nlobj.States(9).Min = -1;
% nlobj.States(10).Min = -1;
% nlobj.States(11).Min = -6;
% nlobj.States(12).Min = -6;
% nlobj.States(13).Min = -6;
% 
% nlobj.States(1).Max = 10;
% nlobj.States(2).Max = 10;
% nlobj.States(3).Max = 10;
% nlobj.States(4).Max = 10;
% nlobj.States(5).Max = 10;
% nlobj.States(6).Max = 10;
% nlobj.States(7).Max = 1;
% nlobj.States(8).Max = 1;
% nlobj.States(9).Max = 1;
% nlobj.States(10).Max = 1;
% nlobj.States(11).Max = 6;
% nlobj.States(12).Max = 6;
% nlobj.States(13).Max = 6;

nlobj.MV(1).Min = -5;
nlobj.MV(1).Max = 0;
nlobj.MV(2).Min = -5;
nlobj.MV(2).Max = 0;
nlobj.MV(3).Min = -5;
nlobj.MV(3).Max = 0;
nlobj.MV(4).Min = -5;
nlobj.MV(4).Max = 0;

nlobj.Weights.OutputVariables = [5,5,5,1,1,1,1,1,1,1,1,1,1];
% nlobj.Weights.ManipulatedVariables = [1,1,1,1]

dyn = @(t,y)(autoGen_dyn_B_com(y(1),y(2),y(3),y(4),y(5),y(6),y(7),y(8),y(9),y(10),y(11),y(12),y(13),u(1),u(2),u(3),u(4)));
% op = @(t,y,flag)idlk(t,y,flag,params);

u0 = [2.0104;2.0104;2.0104;2.0104];
x0 = [0;0;0.5;0;0;0;0;1;0;0;0;0;0];

validateFcns(nlobj,x0,u0)

lmv = u0;
u = u0;
x = x0;
T = 0;
data = [];

for i = 1:100
    
if (T < 2)
    ref = [0,0,1,0,0,0,1,0,0,0,0,0,0];
elseif (T >= 2 && T < 4)
    ref = [1,0,1,0,0,0,1,0,0,0,0,0,0];
elseif (T >= 4 && T < 6)
    ref = [1,1,1,0,0,0,1,0,0,0,0,0,0];
elseif (T >= 6 && T < 8)
    ref = [0,1,1,0,0,0,1,0,0,0,0,0,0];
elseif (T >= 8)
    ref = [0,0,1,0,0,0,1,0,0,0,0,0,0];
end

lmv = nlmpcmove(nlobj,x,lmv,ref);

disp('Control Generated');

x0 = reshape([x;lmv],17,1)
u = lmv;

dyn = @(t,y)(autoGen_dyn_B_com(y(1),y(2),y(3),y(4),y(5),y(6),y(7),y(8),y(9),y(10),y(11),y(12),y(13),u(1),u(2),u(3),u(4)));

disp('Step Simulated');

[t,y] = ode45(dyn,[T T+Ts],x);
data = [data;t,y];

x = y(end,1:13)';

T = T + Ts;

fprintf('Time Step : %d\n',i);
end

save('demo_data.mat','data');


