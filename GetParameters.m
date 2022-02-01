function prm = GetParameters()

prm.XMAX=420; % domain size in x axis
prm.YMAX=80; % domain size in y axis

prm.X_CELL_NUMB=7; % initial cell number in x axis
prm.Y_CELL_NUMB=1; % initial cell number in y axis
prm.X_CELL_LEN=60;
prm.Y_CELL_LEN=30;

prm.looser = 4; % Specify cell id

prm.MAX_CELL_NUMB=prm.X_CELL_NUMB*prm.Y_CELL_NUMB; % Maxiumu cell number, change if proliferative.

prm.MCS_TIME = 1150; % Monte-Carlo time
prm.STEP_MAX = prm.MCS_TIME * prm.XMAX * prm.YMAX;


% "Switch" parameters
prm.XBND=2; % Boundary conditions, 1:Reflection, 2:Periodic
prm.YBND=1; % Boundary conditions, 1:Reflection, 2:Periodic
prm.SUBSTRATE=1; % 1: assuming "substrate" on y=0 


% Size constraint %
prm.LAM_AREA = 1.0;
prm.TARGET_CELL_SIZE=prm.X_CELL_LEN * prm.Y_CELL_LEN * 1.0;

% ---- Interfacial energy ---- %
prm.CellTypeNumb = 3;
CellCell = ... % Cell-Cell interfacial energy <col1:winner, col2:;looser, col3: vesicles>
[2 10 6;
 10 2 10;
 6 10 2];

CellMedium = ... % Cell-Medium interfacial energy
[10; 10; 10];

prm.J_mat=horzcat(CellCell, CellMedium); % Interfacial energy matrix

if prm.SUBSTRATE==1
    CellSubstrate = [2; 10; 10]; % Cell-Substrate interfacial energy
    prm.J_mat=horzcat(prm.J_mat, CellSubstrate); % Cell
end

% Substrate %
prm.LAM_CS_SURF = 100.0;

% Vesicle %
prm.VesicleRegion = 0; % 0:default, 1: basal, 2:luminal/apical, 3:lateral
prm.vesicle_add_rate = 15; % [MCS]
prm.vesicle_decay = 0.01;
prm.vesicle_theta = 0.75*pi; % default: 0.75

% Height of lamellipodia %
prm.height_of_lamellipodia = round(prm.Y_CELL_LEN*0.1); % controlling the region of lamellipodial protrusion

% Lower limit of EV formation % 
prm.vesicle_lower = prm.height_of_lamellipodia*2.5;

prm.TEMPERATURE = 3;

end