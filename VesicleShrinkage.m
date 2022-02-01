function cells = VesicleShrinkage(prm, cells)

vlist = find(cells.type==3 & cells.target_area > 0);

cells.target_area(vlist) = (1 - prm.vesicle_decay) * cells.target_area(vlist);
if cells.target_area<=0
    cells.target_area = 0;
end

end
