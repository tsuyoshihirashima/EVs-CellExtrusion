function [mat_extrusion, output_cnt] = LengthOfExtrusion(prm, sigma, cells, mcs, mat_extrusion, output_cnt)

range = 3;
% Extruding cell
center_x = round(cells.mass(prm.looser,1));
tmp_ext=sigma(:, center_x-range:center_x+range);
center_y=round(cells.mass(prm.looser,2));
ext_apical=[];
cnt=1;
for x = 1:2*range+1
    for y = center_y:prm.YMAX
        if tmp_ext(y,x)==prm.looser && tmp_ext(y+1,x)==0
            ext_apical(cnt)=y;
            cnt=cnt+1;
            break;
        end
    end
end

% Non-extruding cell 1
center_x = round(cells.mass(prm.looser-1,1));
tmp_ext=sigma(:, center_x-range:center_x+range);
center_y=round(cells.mass(prm.looser-1,2));
non_ext_apical1=[];
cnt=1;
for x = 1:2*range+1
    for y = center_y:prm.YMAX
        if tmp_ext(y,x)==prm.looser-1 && tmp_ext(y+1,x)==0
            non_ext_apical1(cnt)=y;
            cnt=cnt+1;
            break;
        end
    end
end
% Non-extruding cell 2
center_x = round(cells.mass(prm.looser+1,1));
tmp_ext=sigma(:, center_x-range:center_x+range);
center_y=round(cells.mass(prm.looser+1,2));
non_ext_apical2=[];
cnt=1;
for x = 1:2*range+1
    for y = center_y:prm.YMAX
        if tmp_ext(y,x)==prm.looser+1 && tmp_ext(y+1,x)==0
            non_ext_apical2(cnt)=y;
            cnt=cnt+1;
            break;
        end
    end
end

extrusion_length = mean(ext_apical) - 0.5*(mean(non_ext_apical1)+mean(non_ext_apical2));

mat_extrusion(output_cnt, 1:2) = [mcs-100 extrusion_length*0.333]; % unit:[µm]
output_cnt = output_cnt+1;

end