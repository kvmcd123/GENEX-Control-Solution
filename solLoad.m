function solutions = solLoad()
    % Grab the files from the solution directory
    files = dir('solData\*.mat');
    
    % Obtain the number of files
    ns = length(files);
    % Create a empty structure to store the solutions
    solutions = struct('x', cell(1,ns),'u', cell(1,ns),'J', cell(1,ns),'Cost', cell(1,ns),'T', cell(1,ns),'Tvals', cell(1,ns));
    % Parallel loop through all the files 
    parfor i = 1:ns
        % Grab a file
        file = files(i);
        % Load the solution
        temp = load(strcat('solData\',file.name));
        
        % Append the solution data to the structure
        solutions(i).x = temp.sol.x;
        solutions(i).u = temp.sol.u;
        solutions(i).J = temp.sol.J;
        solutions(i).Cost = temp.sol.Cost;
        solutions(i).T = temp.sol.T;
        solutions(i).Tvals = temp.sol.Tvals;
        
        % Delete the saved file since the solution is in struct 
        delete(strcat('solData\',file.name));
    end
    % Remove the solution folder
    rmdir('solData');
    % Remove any unneeded space in the solutions structure
    solutions = solutions(all(~cellfun(@isempty,struct2cell(solutions))));
end