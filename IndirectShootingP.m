function sol = IndirectShootingP(xT,m,T,Tg,V,delta)
    z0 = [0.001;0.001;0.001];
    if T == 0
        mkdir('solData');
        tvals = 0.1:delta:Tg;
        parfor i = 1:length(tvals)
            Ttemp = tvals(i);
            f = @(z) shoot(z,Ttemp,xT,m,V);
            [z_optimal,error_optimal] = fsolve(f, z0, optimset('Display','None','Algorithm','levenberg-marquardt'));
            [err,Tt,X] = f(z_optimal);
             if round(X(end,1),4) ==  round(xT(1),4)
                if round(X(end,2),4) == round(xT(2),4)
                    if round(X(end,3),4) ==  round(xT(3),4)
                        JFull = X(:,4);
                        U = zeros(1,length(Tt));
                        for t = 1:size(Tt)
                            U(t) = -((Ttemp-Tt(t))^m)/2*X(t,7);
                        end
                        solSave(struct('x',X,'u',U,'J',JFull,'Cost',max(JFull),'T',Ttemp,'Tvals',Tt),i)
                    end
                end
            end
        end
        solutions = solLoad();
        sol = optimalSolutionFinder(solutions);
    else
        f = @(z) shoot(z,T,xT,m,V);
        [z_optimal,error_optimal] = fsolve(f, z0, optimset('Display','None'));
        [err,Tt,X] = f(z_optimal);
        if round(X(end,1),4) ==  round(xT(1),4)
            if round(X(end,2),4) == round(xT(2),4)
                if round(X(end,3),4) ==  round(xT(3),4)
                    JFull = X(:,4);
                    for t = 1:size(Tt)
                        U(t) = -((T-Tt(t))^m)/2*X(t,7);
                    end
                    sol = struct('x',X,'u',U,'J',JFull,'Cost',max(JFull),'T',T,'Tvals',Tt);
                end
            end
        else
            sol = [];
        end
    end
end