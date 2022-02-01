function [nb_c, nb_x, nb_y, copy_x, copy_y, flag] = GetCandidateLattice(prm, sigma, rnd_x, rnd_y, nb_indx)

switch nb_indx
    case 1
        nb_x=-1; nb_y=-1;
    case 2
        nb_x=-1; nb_y=0;
    case 3
        nb_x=-1; nb_y=1;
    case 4
        nb_x=0; nb_y=-1;
    case 5
        nb_x=0; nb_y=1;
    case 6
        nb_x=1; nb_y=-1;
    case 7
        nb_x=1; nb_y=0;
    case 8
        nb_x=1; nb_y=1;
end


flag = 1;
copy_x = rnd_x+nb_x;
copy_y = rnd_y+nb_y;

%% Sometimes turn "flag" off for the case of "Reflection boundary"
% "Periodic boundary condition" - rewrite if the chosen site is on the boundary

if prm.XBND == 1
    if rnd_x==1 && nb_x==-1 || rnd_x==prm.XMAX && nb_x==1
        flag = 0;
    end
    
elseif prm.XBND==2
    if rnd_x==1 && nb_x==-1
        copy_x=prm.XMAX;
    elseif rnd_x==prm.XMAX && nb_x==1
        copy_x=1;
    end
end

if prm.YBND==1
    if rnd_y==1 && nb_y==-1 || rnd_y==prm.YMAX && nb_y==1
        flag = 0;
    end
    
elseif prm.YBND==2
    if rnd_y==1 && nb_y==-1
        copy_y=prm.YMAX;
    elseif rnd_y==prm.YMAX && nb_y==1
        copy_y=1;
    end
end


%% 
if flag
    nb_c = sigma(copy_y,copy_x);
else
    nb_c = false;
end

end
