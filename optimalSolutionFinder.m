function optimalSolution = optimalSolutionFinder(solFamily)
    % Check if there are any solutions present
    if isempty(solFamily)
        % If not, return a NaN solution
        optimalSolution = struct('x',NaN,'u',NaN,'J',NaN,'Cost',NaN,'T',NaN,'Tvals',NaN);
    else
        % Grab the cost and index of the first solution
        minJ = solFamily(1).Cost;
        minIndex = 1;
        % Loop through the rest of the solutions and keep the one with the
        % lowest cost
        for i = 2:length(solFamily)
            if minJ > solFamily(i).Cost
                minJ = solFamily(i).Cost;
                minIndex = i;
            end
        end
        % Return the lowest costing solution
        optimalSolution = solFamily(minIndex);
    end
end