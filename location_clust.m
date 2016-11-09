

X_test = XCoordinate(2:2002);
Y_test = YCoordinate(2:2002);

Date_test = Date(2:2002);

[foo idx_time] = sort(datenum(Date_test));
X_test = X_test(idx_time);
Y_test = Y_test(idx_time);
%   Discretize the 2D crime points in cell covering the all crime Chicago
%   area holded in the dataset
%
N = length(X_test);
%n = 300304;
n = 256;
n_sqr = sqrt(n);

x_edges = (min(X_test):range(X_test)/sqrt(n):max(X_test));
x_bins = discretize(X_test,x_edges);
y_edges = (min(Y_test):range(Y_test)/sqrt(n):max(Y_test));
y_bins = discretize(Y_test,y_edges);
% Changing NaN group labels to z?roe -999
% x_bins(find(isnan(x_bins)))=-999;
% y_bins(find(isnan(y_bins)))=-999;

agg_cell_map = zeros(n_sqr,n_sqr);
agg_cell_map = zeros(n_sqr,n_sqr);
index_list=[];
for i = 1:n_sqr
    for j = 1:n_sqr
            cell_points = intersect(find(x_bins == i),find(y_bins == j));
            agg_cell_map(i,j) = numel(cell_points);
            index_list =  [index_list, [cell_points]'];
            %agg_cell_map_plot((n_sqr-i+1),j) = numel(cell_points);
    end;
end;
% imagesc(agg_cell_map_plot)
%%
map2list = agg_cell_map(:)';
max_el = max(map2list);
index_matrix = [];
time_matrix = cell(n,max_el);
k = 1;
for i = 1:n
    a_row = padarray(index_list(k: k+map2list(i)-1),[0 (max_el - map2list(i))],'post');
    if map2list(i)>=1
        index_matrix = [index_matrix; a_row];
        [time_matrix{i,(1:map2list(i))}]  = Date_test{k: k+map2list(i)-1};
        k = k + map2list(i);
    end
end

%%
% k = 1;
% for i = 1:n
%     len_dif  = (max_el - map2list(i)) ;
%     a_row = padarray(index_list(k: k+map2list(i)-1),[0 len_dif],'post');
%     disp(len_dif);
% %     if map2list(i)>1
% %         [foo idx] = sort(datenum(Date_test(a_row(1:(map2list(i))))));
% %         a_row(1:map2list(i)) = a_row(idx);
% %     end
%     index_matrix = [index_matrix; a_row];
%     k = k + map2list(i); 
% end


% if map2list(i)>=1
%         a_row(1:map2list(i)) = Date_test(a_row(idx));
%         time_matrix  = [time_matrix; Date(a_row)];
%     end

