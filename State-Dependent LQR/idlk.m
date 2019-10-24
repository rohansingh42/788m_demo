function status = idlk(t,y,flag,params)
global tt yy uu
if nargin < 3 || isempty(flag)
tt = [tt;t(end).'];
yy = [yy;y(:,end).'];
nu = quad_sdlqr(t(end),y(:,end),params,uu(end,:));
uu = [uu;nu.'];
else
switch(flag)
case 'init'
fprintf('start\n');
tt = t(end).';
yy = y(:,end).';
uu = [uu;params.u0.'];
case 'done'
fprintf('done\n');
end
end
status = 0;
end