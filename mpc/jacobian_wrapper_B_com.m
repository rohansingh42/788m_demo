function [a,b] = jacobian_wrapper_B_com(x,u)

a = autoGen_jac_dxx_B_com(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),x(9),x(10),x(11),x(12),x(13),u(1),u(2),u(3),u(4));
b = autoGen_jac_dxu_B_com(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),x(9),x(10),x(11),x(12),x(13),u(1),u(2),u(3),u(4));

end