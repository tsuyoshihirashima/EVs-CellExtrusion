function out=GetInitialConfiguration(prm)

mat=1:prm.X_CELL_NUMB*prm.Y_CELL_NUMB;
mat=reshape(mat, prm.X_CELL_NUMB, prm.Y_CELL_NUMB)';
mat=repelem(mat, prm.Y_CELL_LEN, prm.X_CELL_LEN);
[len_row, len_col]=size(mat);

out=zeros(prm.YMAX, prm.XMAX);
out(1:len_row,1:len_col)=mat;

% Positioned in the center
%out=circshift(out,[round((prm.YMAX-len_row)/2) round((prm.XMAX-len_col)/2)]);

% Positioned in the bottom
out=circshift(out,[0 round((prm.XMAX-len_col)/2)]);

end