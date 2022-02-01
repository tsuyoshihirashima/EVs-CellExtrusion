%% main.m
% This program is used for a submitted manuscript Kira et al.
% Credits: Tsuyoshi Hirashima at Kyoto University
% hirashima.tsuyoshi.2m (at) kyoto-u.ac.jp

close all
clear
tic

%% Parameter Setting
prm = GetParameters();

%% Initial Condition
sigma = GetInitialConfiguration(prm);

%% Setting for Model Variables and Parameters
cells = SetInitialParameters(prm, sigma);

%% Monte-Carlo Dynamics
x_vec = randi(prm.XMAX, prm.STEP_MAX, 1);
y_vec = randi(prm.YMAX, prm.STEP_MAX, 1);
nb_vec = randi(8, prm.STEP_MAX, 1); % for 2D setting
rnd_vec = rand(prm.STEP_MAX, 1, 'single');

mcs_unit = prm.XMAX*prm.YMAX;

for mcs = 1 : prm.MCS_TIME
    for dummy_t = 1 : mcs_unit
        step = (mcs-1)*mcs_unit + dummy_t;
        
        rnd_x = x_vec(step);
        rnd_y = y_vec(step);
        c = sigma(rnd_y,rnd_x);
        nb_indx = nb_vec(step);
        
        [nb_c, nb_x, nb_y, copy_x, copy_y, flag_update] = GetCandidateLattice(prm, sigma, rnd_x, rnd_y, nb_indx); % flag_update becomes'false' only when BND==1
        
        if flag_update && c ~= nb_c
            
            % Calculation of energy difference and transition probability
            e_all = GetAdhesionEnergyDiff(prm, cells, sigma, rnd_x, rnd_y, c, nb_c)...
                + GetSizeEnergyDiff(prm, cells, c, nb_c) ...
                + GetCellSubstrateSurfaceDiff(prm, cells, c, nb_c, rnd_y);
            
            % Calculation of Transit Probability
            if e_all >= 0
                prob = exp(-e_all/prm.TEMPERATURE);
            elseif e_all < 0
                prob = 1.0;
            end
            
            % Update of the state
            if prob >= rnd_vec(step)
                sigma(rnd_y, rnd_x) = nb_c;
                cells = UpdateOfMass(prm, cells, rnd_x, rnd_y, c, nb_c); % Required "BEFORE" UpdateOfArea function
                cells = UpdateOfArea(cells, c, nb_c);
            end
            
        end
    end
    
    %% Loser cell specification
    if mcs==100
        cells.type(prm.looser)= 2; % loser cell is indexed as "2"
        cells.subspread(prm.looser) = 0;
    end
    
    
    %% Output Figure
    if mod(mcs,100)==0
        disp(['mcs: ', num2str(mcs)])
        OutputCellFigure(prm, cells, sigma, mcs)
    end
    
    %% Vesicle shrinkage
    cells = VesicleShrinkage(prm, cells);
    
    %% Vesicle formation
    if mod(mcs, prm.vesicle_add_rate)==0 && mcs>150
        [sigma, cells] = VesicleFormation(prm, sigma, cells); % vesicles added one-by-one
    end
    
end

toc
