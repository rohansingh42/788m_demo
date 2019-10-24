function xd = spacial_tracking(t,y,params)

global iter

p = reshape(y(1:3),[3 1]);
q = reshape(y(4:7),[4 1]);
v = reshape(y(8:10),[3 1]);

xdes = params.xdes.';
[m,n]=size(xdes);

for i = (iter+1):n
    
    d = xdes(1:3,i) - xdes(1:3,i-1);
    gamma = dot((p - xdes(1:3,i-1)),d)/(norm(d)^2);
    
    if gamma>=1 
        iter = i;
        xd = xdes(:,iter-1) + gamma*(xdes(:,iter) - xdes(:,iter-1));
        break;
    end
end
    
end