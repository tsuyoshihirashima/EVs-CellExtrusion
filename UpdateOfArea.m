function cells = UpdateOfArea(cells, c, nb_c)

if c > 0
    cells.area(c) = cells.area(c) - 1;
end

if nb_c > 0
    cells.area(nb_c) = cells.area(nb_c) + 1;
end

end
