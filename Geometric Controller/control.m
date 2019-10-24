function c = control(t,y,params)
digits(4)

global ldv;
global lt;
global ld3x;

x = y(1:3);
v = y(4:6);
W = y(7:9);
R = [y(10:12)';y(13:15)';y(16:18)'];

xd = vpa(subs(params.xd,t));
vd = vpa(subs(params.dxd,t));
ddxd = vpa(subs(params.ddxd,t));
d3xd = vpa(subs(params.d3xd,t));
d4xd = vpa(subs(params.d4xd,t));
b1d = vpa(subs(params.b1d,t));
db1d = vpa(subs(params.db1d,t));
ddb1d = vpa(subs(params.ddb1d,t));

ex = x - xd;
ev = v - vd;

a1 = vpa(-params.kx*ex - params.kv*ev - params.m*params.g*params.e3 + params.m*ddxd);

b3d = -a1/norm(a1);

f = dot(-a1,R*params.e3);

dv =  params.g*params.e3 - (1/params.m)*f*R*params.e3;
ea = dv - ddxd;

% approximate and crude method of calculating d3dx
% if (t-lt) < 1e-2
%     ej = ld3x - d3xd;
% else
%     dv-ldv
%     t-lt
%     d3x = (dv - ldv)/(t-lt);
%     ej = d3x - d3xd;
%     ld3x = d3x;
% end
% 
% ldv = dv;
% lt =  t;

a2 = cross(b3d,b1d);
b1d = -(1/norm(a2))*cross(b3d,a2);
b2d = a2/norm(a2);

Rd = [b1d b2d b3d]

da1 = -params.kx*ev - params.kv*ea + params.m*d3xd;
db3d = -da1/norm(a1) + (dot(a1,da1)/norm(a1)^3)*a1;
da2 = cross(db3d,b1d) + cross(b3d,db1d);
db2d = da2/norm(a2) - (dot(a2,da2)/norm(a2)^3)*a2; 
db1d = cross(db2d,b3d) + cross(b2d,db3d);

% more accurate method for d3dx (both methods have almost same results though)
dR = R*hat(W);
df = -dot(da1,R*params.e3) - dot(a1,dR*params.e3);
d3x = (1/params.m)*(df*R*params.e3 + f*dR*params.e3);
ej = d3x - d3xd;

dda1 = - params.kx*ea - params.kv*ej + params.m*d4xd;
ddb3d = - dda1/norm(a1) + (2/norm(a1)^3)*dot(a1,da1)*da1 ...
        + ((norm(da1)^2 + dot(a1,dda1))/norm(a1)^3)*a1 - (3/norm(a1)^5)*(dot(a1,da1)^2)*a1;
dda2 = cross(ddb3d,b1d) + cross(db3d,db1d) ...
       + cross(db3d,db1d) + cross(b3d,ddb1d);
ddb2d = dda2/norm(a2) - (2/norm(a2)^3)*dot(a2,da2)*da2 ...
        - ((norm(da2)^2 + dot(a2,dda2))/norm(a2)^3)*a2 + (3/norm(a2)^5)*(dot(a2,da2)^2)*a2;  
ddb1d = cross(ddb2d,b3d) + cross(db2d,db3d) ...
        + cross(db2d,db3d) + cross(b2d,ddb3d);
    
dRd = [db1d db2d db3d];
ddRd = [ddb1d ddb2d ddb3d];
Wd = vee(Rd.'*dRd);
dWd = vee(Rd.'*ddRd - hat(Wd)*hat(Wd));   

er = 0.5*vee(Rd.'*R - R.'*Rd);
ew = W - R.'*Rd*Wd;

Psi = 0.5*trace(eye(3) - Rd.'*R);

M = - params.kr*er - params.kw*ew + cross(W,params.J*W) - params.J*(hat(W)*R.'*Rd*Wd - R.'*Rd*dWd);

c = double([f;M]);
end