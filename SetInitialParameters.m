function [cells]=SetInitialParameters(prm, sigma)

cells.numb=max(sigma(:));
cells.initnumb = cells.numb;

%% Cell Area
cells.area = zeros(cells.numb,1);
for i=1:cells.numb
    cells.area(i,1)=sum(sum(sigma==i));
end

%% Cell Target Area
cells.target_area(1:cells.numb,1)=prm.TARGET_CELL_SIZE;

%% Cell Type
%cells.type=randi(prm.CellTypeNumb, cells.numb, 1); % 1: light cell, 2: dark cell
cells.type=ones(cells.numb,1);
%cells.type(5)=2;

%% Cell Mass Position
cells.mass=zeros(cells.numb,2);
for i=1:cells.numb
    [yy, xx] = find(sigma==i);
    cells.mass(i,1) = mean(xx);
    cells.mass(i,2) = mean(yy);
end

%% Cell Substrate Spreading
cells.subspread = ones(cells.numb,1)*prm.LAM_CS_SURF;

%% Vesicle size
cells.vesicle_size(1) = 0;

end
