function solSave(sol,i)
    loc = strcat(strcat('solData\sol',num2str(i)),'.mat');
    save(loc,'sol'); 
end