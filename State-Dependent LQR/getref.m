function [xdes,udes] = getref(t,y,params)


if (t < 2)
    xdes = [0;0;1;0.99;0;0;0;0;0;0];
    udes = [0;0;0;10];
elseif (t >= 2 && t < 4)
    xdes = [1;0;1;0.99;0;0;0;0;0;0];
    udes = [0;0;0;10];
elseif (t >= 4 && t < 6)
    xdes = [1;1;1;0.99;0;0;0;0;0;0];
    udes = [0;0;0;10];
elseif (t >= 6 && t < 8)
    xdes = [0;1;1;0.99;0;0;0;0;0;0];
    udes = [0;0;0;10];
elseif (t >= 8)
    xdes = [0;0;1;0.99;0;0;0;0;0;0];
    udes = [0;0;0;10];
end

end