function [target_error, tVals, X] = shoot(z,T,xT,m,V)
    % Simulate the system
    [tVals,X] = ode45 (@(t,x) dynamics(t,x,T,m,V),[0 T], [0;0;0;0;z(1);z(2);z(3)]);
    
    % Calculate the error of the terminal state
    target_error = zeros(4,1);
    target_error(1) = xT(1) - X(end,1);
    target_error(2) = xT(2) - X(end,2);
    target_error(3) = xT(3) - X(end,3);
end