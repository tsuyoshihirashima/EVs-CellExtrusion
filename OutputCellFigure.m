function OutputCellFigure(prm, cells, sigma, mcs)

cell_numb = max(sigma(:));

cell_type=zeros(prm.YMAX,prm.XMAX);
for i=1:cell_numb
    cell_type(sigma==i) = cells.type(i);
end

%        figure(step),
h1=pcolor(cell_type);
set(h1, 'EdgeColor', 'none');
colormap(flipud(pink))
%colormap(flipud(bone))
%caxis([0 max(cells.type)+0.5])
caxis([0.0 3.5])
hold on

[y1, x1] = find(sigma ~= circshift(sigma,[1 0]));
[y2, x2] = find(sigma ~= circshift(sigma,[0 1]));
line_x=horzcat([x1 x1+1]',[x2 x2]');
line_y=horzcat([y1 y1]',[y2 y2+1]');

h2=plot(line_x,line_y,'-');
%set(h2, 'Color', [0.95 0.95 0.95]);
set(h2, 'Color', [0.7 0.7 0.7]);

axis equal
axis([1 prm.XMAX 1 prm.YMAX])
box off
ax = gca;
%box on
%ax.BoxStyle = 'full';
%ax.LineWidth = 1.5;
%set(ax,'XTick',[], 'YTick', [])

% Mass of centers
%plot(cells.mass(:,1), cells.mass(:,2),'o','MarkerEdgeColor','y')

hold off


% ----- Range of EVs formed ----- %
%{
if mcs>150
    hold on
    mx = cells.mass(4,1);
    my = cells.mass(4,2);
    plot(mx, my, 'ok')

    l = prm.Y_CELL_LEN; % standard length of the lines
    if prm.VesicleRegion==4
        x0 = [mx-l; mx+l];
        y0 = [my; my];
        x1 = [mx; mx-l*cos(0.5*prm.vesicle_theta)];
        y1 = [my; my-l*sin(0.5*prm.vesicle_theta)];
        x2 = [mx; mx+l*cos(0.5*prm.vesicle_theta)];
        y2 = y1;

        x = [x0, x1, x2];
        y = [y0, y1, y2];
        line(x,y,'Color','blue','LineStyle','-')
    end

    hold off
end
%}


pause(0.01)

end