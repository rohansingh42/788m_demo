function u = quad_sdlqr(t,y,params,prevu)

p = reshape(y(1:3),[3 1]);
q = reshape(y(4:7),[4 1]);
v = reshape(y(8:10),[3 1]);
nq = norm(q)
% q*q.'
ddqu_dq = (eye(4) - (nq^-2)*q*q.')*(nq^-1)    % qu = q.(norm(q)^-1)

wx = prevu(1);
wy = prevu(2);
wz = prevu(3);
c = prevu(4);

qw = q(1);
qx = q(2);
qy = q(3);
qz = q(4);

ddp_dv = eye([3 3]);
ddq_dq = 0.5*[ 0, -wx, -wy, -wz;...
              wx,   0,  wz, -wy;...
              wy, -wz,   0,  wx;...
              wz,  wy, -wx,   0]*ddqu_dq
ddq_dw = 0.5*[-qx, -qy, -qz;...
               qw, -qz, -qy;...
               qz,  qw,  qx;...
              -qy,  qx,  qw]
ddv_dq = 2*c*[ qy,  qz,  qw, qx;...
              -qx, -qw,  qz, qy;...
               qw, -qx, -qy, qz]*ddqu_dq
ddv_dc = [            qw*qy + qx*qz;...
                      qy*qz - qw*qx;...
          qw^2 - qx^2 - qy^2 + qz^2]
      
A = [zeros(3),   zeros(3,4), ddp_dv;...
     zeros(4,3), ddq_dq,     zeros(4,3);...
     zeros(3) ,  ddv_dq,     zeros(3)];
B = [zeros(3), zeros(3,1);...
       ddq_dw, zeros(4,1);...
     zeros(3),    ddv_dc];
 
% eig(A)
% eig(B)
Q = params.Q;
R = params.R;
% inv(R)*B.'

% minreal(ss(A,B,[],[]))
rank(ctrb(A,B))


[K,S,e] = lqr(A,B,Q,R);
% [X,L,G] = dare(A,B,Q,R);
% K=G
% xdes = spatial_tracking(t,y,params);
[xdes, udes] = getref(t,y,params);

K
K*([p;q;v]-xdes)
u = (udes - K*([p;q;v]-xdes));
([p;q;v]-xdes);

end