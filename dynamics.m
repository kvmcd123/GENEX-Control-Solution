function dxdt = dynamics(t,x,T,m,V)
    
    % Calculate the input
    u = -(((T-t)^m)/2)*x(7);

    dxdt = zeros(7,1);
    
    % The actual system dynamics
    dxdt(1) = V*cos(x(3));                      % x
    dxdt(2) = V*sin(x(3));                      % y
    dxdt(3) = u;                                % theta

    % The objective function dynamics
    dxdt(4) = (u.^2)/((T-t)^m);                 % J
    
    % The adjoint system dynamics 
    dxdt(5) = 0;                                % lambda_1
    dxdt(6) = 0;                                % lambda_2
    dxdt(7) = x(5)*dxdt(2) - x(6)*dxdt(1);      % lambda_3

end