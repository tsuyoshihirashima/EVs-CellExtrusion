function out = GetAdhesionEnergyDiff(prm, cells, sigma, rnd_x, rnd_y, c, nb_c)

% Create local matrix
local_mat = GetLocalMatrix(prm, sigma, rnd_x, rnd_y);

%% Adhesion calculation
%% 1. Before ----------------------
e_adhesion = 0;
before_mat=local_mat(local_mat~=c);

if c>0 % when the active cell is chosen
    
    non_zero=before_mat(find(before_mat>0)); 
    e_adhesion = e_adhesion + sum(prm.J_mat(cells.type(c), cells.type(non_zero))); % cell-cell
    
    zero=before_mat(find(before_mat==0));
    e_adhesion = e_adhesion + numel(zero) * prm.J_mat(cells.type(c), prm.CellTypeNumb+1); % cell-medium
    
    if prm.SUBSTRATE==1 && rnd_y==1
        e_adhesion = e_adhesion + prm.J_mat(cells.type(c), prm.CellTypeNumb+2); % cell-substrate 
    end
    
elseif c==0 % when the medium is chosen
    
    non_zero=before_mat(find(before_mat>0)); 
    e_adhesion = e_adhesion + sum(prm.J_mat(cells.type(non_zero), prm.CellTypeNumb+1)); % cell-medium
    
end


%% 2. After ----------------------
new_e_adhesion = 0;
after_mat=local_mat(local_mat~=nb_c);

if nb_c>0 % when the active cell is chosen
    
    non_zero=after_mat(find(after_mat>0)); 
    new_e_adhesion = new_e_adhesion + sum(prm.J_mat(cells.type(nb_c), cells.type(non_zero))); % cell-cell
    
    zero=after_mat(find(after_mat==0));
    new_e_adhesion = new_e_adhesion + numel(zero) * prm.J_mat(cells.type(nb_c), prm.CellTypeNumb+1); % cell-medium
    
    if prm.SUBSTRATE==1 && rnd_y==1
        new_e_adhesion = new_e_adhesion + prm.J_mat(cells.type(nb_c), prm.CellTypeNumb+2); % cell-substrate
    end

elseif nb_c==0 % when the medium is chosen
    
    non_zero=after_mat(find(after_mat>0)); 
    new_e_adhesion = new_e_adhesion + sum(prm.J_mat(cells.type(non_zero), prm.CellTypeNumb+1)); % cell-medium
    
end

%% 3. Difference
out = new_e_adhesion - e_adhesion;


end