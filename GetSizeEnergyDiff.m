function e_area=GetSizeEnergyDiff(prm, cells, c, nb_c)

e_area1=0;
if c>0
    e_area1 = prm.LAM_AREA*(1 - 2*cells.area(c) + 2*cells.target_area(c));
end
e_area2=0;
if nb_c>0
    e_area2 = prm.LAM_AREA*(1 + 2*cells.area(nb_c) - 2*cells.target_area(nb_c));
end

e_area = e_area1 + e_area2;

end