function local_mat = GetLocalMatrix(prm, sigma, rnd_x, rnd_y)

% Create local matrix
if rnd_x==1
    min_x=0; max_x=1; center_x=1;
elseif rnd_x==prm.XMAX
    min_x=1; max_x=0; center_x=2;
else
    min_x=1; max_x=1; center_x=2;
end

if rnd_y==1
    min_y=0; max_y=1; center_y=1;
elseif rnd_y==prm.YMAX
    min_y=1; max_y=0; center_y=2;
else
    min_y=1; max_y=1; center_y=2;
end

local_mat=sigma(rnd_y-min_y:rnd_y+max_y,rnd_x-min_x:rnd_x+max_x);


if prm.XBND==2 && prm.YBND==1 % Periodic boundary on x-axis
    center_x=2;
    
    if rnd_x==1 && 1<rnd_y && rnd_y<prm.YMAX
        local_mat=horzcat(sigma(rnd_y-1:rnd_y+1,prm.XMAX),local_mat);
    elseif rnd_x==prm.XMAX && 1<rnd_y && rnd_y<prm.YMAX
        local_mat=horzcat(local_mat,sigma(rnd_y-1:rnd_y+1,1));
        
    elseif rnd_x==1 && rnd_y==1 % corner
        local_mat=horzcat(sigma(1:2,prm.XMAX),local_mat);
    elseif rnd_x==prm.XMAX && rnd_y==1 % cornder
        local_mat=horzcat(local_mat,sigma(1:2,1));
    elseif rnd_x==1 && rnd_y==prm.YMAX % corner
        local_mat=horzcat(sigma(prm.YMAX-1:prm.YMAX,prm.XMAX),local_mat);
    elseif rnd_x==prm.XMAX && rnd_y==prm.YMAX % corner
        local_mat=horzcat(local_mat,sigma(prm.YMAX-1:prm.YMAX,1));
    end
    
elseif prm.XBND==1 && prm.YBND==2 % Periodic boundary on y-axis
    center_y=2;
    
    if 1<rnd_x && rnd_x<prm.XMAX && rnd_y==1
        local_mat=vertcat(sigma(prm.YMAX, rnd_x-1:rnd_x+1), local_mat);
    elseif 1<rnd_x && rnd_x<prm.XMAX && rnd_y==prm.YMAX
        local_mat=vertcat(local_mat, sigma(1, rnd_x-1:rnd_x+1));
        
    elseif rnd_x==1 && rnd_y==1 % corner
        local_mat=vertcat(sigma(prm.YMAX, 1:2), local_mat);
    elseif rnd_x==prm.XMAX && rnd_y==1 % cornder
        local_mat=vertcat(sigma(prm.YMAX, prm.XMAX-1:prm.XMAX), local_mat);
    elseif rnd_x==1 && rnd_y==prm.YMAX % corner
        local_mat=vertcat(local_mat, sigma(1, 1:2));
    elseif rnd_x==prm.XMAX && rnd_y==prm.YMAX % corner
        local_mat=vertcat(local_mat, sigma(1, prm.XMAX-1:prm.XMAX));
    end
    
elseif prm.XBND==2 && prm.YBND==2 % Periodic boundary on both x and y-axis
    center_x=2; center_y=2;
    
    if rnd_x==1 && 1<rnd_y && rnd_y<prm.YMAX
        local_mat=horzcat(sigma(rnd_y-1:rnd_y+1,prm.XMAX),local_mat);
    elseif rnd_x==prm.XMAX && 1<rnd_y && rnd_y<prm.YMAX
        local_mat=horzcat(local_mat,sigma(rnd_y-1:rnd_y+1,1));
    elseif 1<rnd_x && rnd_x<prm.XMAX && rnd_y==1
        local_mat=vertcat(sigma(prm.YMAX, rnd_x-1:rnd_x+1), local_mat);
    elseif 1<rnd_x && rnd_x<prm.XMAX && rnd_y==prm.YMAX
        local_mat=vertcat(local_mat, sigma(1, rnd_x-1:rnd_x+1));
        
    elseif rnd_x==1 && rnd_y==1 % corner
        local_mat=horzcat(sigma(1:2,prm.XMAX),local_mat); % 2x3 matrix
        tmp = [sigma(prm.YMAX,prm.XMAX) sigma(prm.YMAX, 1:2)];
        local_mat=vertcat(tmp, local_mat);
    elseif rnd_x==prm.XMAX && rnd_y==1 % cornder
        local_mat=horzcat(local_mat,sigma(1:2,1)); % 2x3 matrix
        tmp = [sigma(prm.YMAX, prm.XMAX-1:prm.XMAX) sigma(prm.YMAX,1)];
        local_mat=vertcat(tmp, local_mat);
    elseif rnd_x==1 && rnd_y==prm.YMAX % corner
        local_mat=horzcat(sigma(prm.YMAX-1:prm.YMAX,prm.XMAX),local_mat);
        tmp = [sigma(1,prm.XMAX) sigma(1,1:2)];
        local_mat=vertcat(local_mat, tmp);
    elseif rnd_x==prm.XMAX && rnd_y==prm.YMAX % corner
        local_mat=horzcat(local_mat,sigma(prm.YMAX-1:prm.YMAX,1));
        tmp = [sigma(1,prm.XMAX-1:prm.XMAX) sigma(1,1)];
        local_mat=vertcat(local_mat, tmp);
    end
end

local_mat(center_y,center_x)=NaN;
local_mat=reshape(local_mat,numel(local_mat),1);
local_mat(isnan(local_mat))=[]; % Delete the first-chosen lattice

end