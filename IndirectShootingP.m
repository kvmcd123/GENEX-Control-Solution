function sol = IndirectShootingP(xT,m,T,Tg,V,delta)
    % Make an initial guess of the vector of unknowns
    z0 = [0.001;0.001;0.001];

    % Check if free time is selected 
    if T == 0
        % Create folder to store solutions
        mkdir('solData');
        % Initialize possible time values based on a maximum time value
        tvals = 0.1:delta:Tg;
        
        % Parallel Loop through time values
        parfor i = 1:length(tvals)
            % Grab the time values
            Ttemp = tvals(i);
            
            % Create a function handle with unknown parameter z.
            % Include any preset parameters here
            f = @(z) shoot(z,Ttemp,xT,m,V);

            % Use fsolve to find the optimal values of unknowns z
            [z_optimal,error_optimal] = fsolve(f, z0, ...
                optimset('Display','None','Algorithm','levenberg-marquardt'));
            
            % Obtain the trajectory data using the optimal z parameter
            [err,Tt,X] = f(z_optimal);

            % Check that the desired x-position has been reached
            if round(X(end,1),4) ==  round(xT(1),4)
                % Check that the desired y-position has been reached
                if round(X(end,2),4) == round(xT(2),4)
                    % Check that the desired heading has been reached
                    if round(X(end,3),4) ==  round(xT(3),4)
                        % Grab the cost
                        JFull = X(:,4);
                        
                        % Generate the optimal control 
                        U = zeros(1,length(Tt));
                        for t = 1:size(Tt)
                            U(t) = -((Ttemp-Tt(t))^m)/2*X(t,7);
                        end
                        
                        % Save the solution
                        solSave(struct('x',X,'u',U,'J',JFull,'Cost',max(JFull),'T',Ttemp,'Tvals',Tt),i)
                    end
                end
            end
        end
        % After all time values have been tested, load all the solutions
        solutions = solLoad();
        
        % Find the cheapest option out of all the solutions to consider the
        % global optimal
        sol = optimalSolutionFinder(solutions);
    else
        % Create a function handle with unknown parameter z.
        % Include any preset parameters here
        f = @(z) shoot(z,T,xT,m,V);
        
        % Use fsolve to find the optimal values of unknowns z
        [z_optimal,error_optimal] = fsolve(f, z0, optimset('Display','None'));
        
        % Obtain the trajectory data using the optimal z parameter
        [err,Tt,X] = f(z_optimal);
        % Check that the desired x-position has been reached
        if round(X(end,1),4) ==  round(xT(1),4)
            % Check that the desired y-position has been reached
            if round(X(end,2),4) == round(xT(2),4)
                % Check that the desired heading has been reached
                if round(X(end,3),4) ==  round(xT(3),4)
                    % Grab the cost
                    JFull = X(:,4);
                    % Generate the optimal control
                    U = zeros(1,length(Tt));
                    for t = 1:size(Tt)
                        U(t) = -((T-Tt(t))^m)/2*X(t,7);
                    end
                    % Save the solution
                    sol = struct('x',X,'u',U,'J',JFull,'Cost',max(JFull),'T',T,'Tvals',Tt);
                end
            end
        else
            % Return an empty solution if an error occurs
            sol = [];
        end
    end
end