function optimalSolution = optimalSolutionFinder(solFamily)
    if isempty(solFamily)
        optimalSolution = struct('x',NaN,'u',NaN,'J',NaN,'Cost',NaN,'T',NaN,'Tvals',NaN);
    else
        minJ = solFamily(1).Cost;
        minIndex = 1;
        for i = 2:length(solFamily)
            if minJ > solFamily(i).Cost
                minJ = solFamily(i).Cost;
                minIndex = i;
            end
        end
        optimalSolution = solFamily(minIndex);
    end
end