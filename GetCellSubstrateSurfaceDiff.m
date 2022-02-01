function e_cs = GetCellSubstrateSurfaceDiff(prm, cells, c, nb_c, rnd_y)

e_cs1=0;
if c>0 && 1<=rnd_y && rnd_y<=prm.height_of_lamellipodia
    e_cs1 = cells.subspread(c);
end

e_cs2=0;
if nb_c>0 && 1<=rnd_y && rnd_y<=prm.height_of_lamellipodia
    e_cs2 = -cells.subspread(nb_c);
end

e_cs = e_cs1 + e_cs2;

end