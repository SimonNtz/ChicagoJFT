function C = cell_array_merging(c)

    for j = 1 : size(c,2)
    temp = [];
        for i = 1:size(c,1)
        temp = vertcat(temp,c{i,j});
        end
        C{j} = temp;
    end

end