function solSave(sol,i)
    % Create the file path
    loc = strcat(strcat('solData\sol',num2str(i)),'.mat');
    % Save the solution
    save(loc,'sol'); 
end