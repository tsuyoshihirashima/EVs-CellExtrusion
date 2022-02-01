function cells = UpdateOfMass(prm, cells, rnd_x, rnd_y, c, nb_c)
% Required to be placed "AFTER" UpdateOfArea function
% Note that the last "cells.area(c or nb_c)" is the already-updated cell
% area

if c > 0
    
    main_x = rnd_x; main_y = rnd_y;
    
    if prm.XBND==2
        if cells.mass(c,1)<prm.XMAX/4 && rnd_x>prm.XMAX/4*3
            main_x = rnd_x - prm.XMAX;
        elseif cells.mass(c,1)>prm.XMAX/4*3 && rnd_x<prm.XMAX/4
            main_x = rnd_x + prm.XMAX;
        end
    end
    
    if prm.YBND==2
        if cells.mass(c,2)<prm.YMAX/4 && rnd_y>prm.YMAX/4*3
            main_y = rnd_y - prm.YMAX;
        elseif cells.mass(c,2)>prm.YMAX/4*3 && rnd_y<prm.YMAX/4
            main_y = rnd_y + prm.YMAX;
        end
    end
    
    rnd = [main_x main_y];
    cells.mass(c,:) = (cells.mass(c,:)*cells.area(c) - rnd)/(cells.area(c)-1);
   
    if prm.XBND==2 % Periodic boundary condition on x-axis
        if cells.mass(c,1) < 0
            cells.mass(c,1) = prm.XMAX + cells.mass(c,1);
        elseif prm.XMAX < cells.mass(c,1)
            cells.mass(c,1) = cells.mass(c,1) - prm.XMAX;
        end
    end
    if prm.YBND==2 % Periodic boundary condition on y-axis
        if cells.mass(c,2) < 0
            cells.mass(c,2) = prm.YMAX + cells.mass(c,2);
        elseif prm.YMAX < cells.mass(c,2)
            cells.mass(c,2) = cells.mass(c,2) - prm.YMAX;
        end
    end
end



if nb_c > 0
    
    main_x = rnd_x; main_y = rnd_y;

    if prm.XBND==2
        if cells.mass(nb_c,1)<prm.XMAX/4 && rnd_x>prm.XMAX/4*3
            main_x = rnd_x - prm.XMAX;
        elseif cells.mass(nb_c,1)>prm.XMAX/4*3 && rnd_x<prm.XMAX/4
            main_x = rnd_x + prm.XMAX;
        end
    end
    
    if prm.YBND==2
        if cells.mass(nb_c,2)<prm.YMAX/4 && rnd_y>prm.YMAX/4*3
            main_y = rnd_y - prm.YMAX;
        elseif cells.mass(nb_c,2)>prm.YMAX/4*3 && rnd_y<prm.YMAX/4
            main_y = rnd_y + prm.YMAX;
        end
    end
    
    rnd = [main_x main_y];
    cells.mass(nb_c,:) = (cells.mass(nb_c,:)*cells.area(nb_c) + rnd)/(cells.area(nb_c)+1);
     
    if prm.XBND==2 % Periodic boundary condition on x-axis
        if cells.mass(nb_c,1) < 0
            cells.mass(nb_c,1) = prm.XMAX + cells.mass(nb_c,1);
        elseif prm.XMAX < cells.mass(nb_c,1)
            cells.mass(nb_c,1) = cells.mass(nb_c,1) - prm.XMAX;
        end
    end
    if prm.YBND==2 % Periodic boundary condition on y-axis
        if cells.mass(nb_c,2) < 0
            cells.mass(nb_c,2) = prm.YMAX + cells.mass(nb_c,2);
        elseif prm.YMAX < cells.mass(nb_c,2)
            cells.mass(nb_c,2) = cells.mass(nb_c,2) - prm.YMAX;
        end
    end
end


end
