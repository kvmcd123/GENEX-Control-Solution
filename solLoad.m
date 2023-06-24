function solutions = solLoad()
    files = dir('solData\*.mat');
    ns = length(files);
    solutions = struct('x', cell(1,ns),'u', cell(1,ns),'J', cell(1,ns),'Cost', cell(1,ns),'T', cell(1,ns),'Tvals', cell(1,ns));
    parfor i = 1:ns
        file = files(i);
        temp = load(strcat('solData\',file.name));
        solutions(i).x = temp.sol.x;
        solutions(i).u = temp.sol.u;
        solutions(i).J = temp.sol.J;
        solutions(i).Cost = temp.sol.Cost;
        solutions(i).T = temp.sol.T;
        solutions(i).Tvals = temp.sol.Tvals;
        delete(strcat('solData\',file.name));
    end
    rmdir('solData');
    solutions = solutions(all(~cellfun(@isempty,struct2cell(solutions))));
end