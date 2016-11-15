%% Locatation Clust

%% Starting number of features
N = 200000;
%% Data cleaning 
% Remove NaN and O values from the x,y position vectors
[X_test,Y_test,Idx] =  data_clean(XCoordinate(1:N),YCoordinate(1:N));

% Use the index to also remove this entries from the others vectors
% features
Date_test = Date(Idx);
%% Cluster samples into nodes
%   Discretize the 2D crime points in cell covering the all crime Chicago
%   area holded in the dataset
%
n = 256;
n_sqr = sqrt(n);

x_edges = (min(X_test):range(X_test)/sqrt(n):max(X_test));
x_bins = discretize(X_test,x_edges);

y_edges = (min(Y_test):range(Y_test)/sqrt(n):max(Y_test));
y_bins = discretize(Y_test,y_edges);

agg_cell_map = zeros(n_sqr,n_sqr);
index_list=[];

for i = 1:n_sqr
    for j = 1:n_sqr
            cell_points = intersect(find(x_bins == i),find(y_bins == j));
            agg_cell_map(i,j) = numel(cell_points);
            index_list =  [index_list, [cell_points]'];
            agg_cell_map_plot((n_sqr-i+1),j) = numel(cell_points);
    end;
end;
% imagesc(agg_cell_map_plot)

map2list = agg_cell_map(:)';
max_el = max(map2list);
index_matrix = [];
k = 1;
for i = 1:n
    a_row = padarray(index_list(k: k+map2list(i)-1),[0 (max_el - map2list(i))],'post');
    index_matrix = [index_matrix; a_row];
    k = k + map2list(i);
end

%% Form times series

% active_nodes = index_matrix(map2list ~=0,:);
% new_map_index = map2list(map2list ~=0);
% 
% 
% [delta_t,start_count] = timeformat(Date_test,'week');
% X = [];
%  for i = 1:size((active_nodes),1)
%     a_row = active_nodes(i,(1:new_map_index(i)));
%     date_list = datenum(datestr(Date_test(a_row),1));
%     temp = ceil(((date_list - start_count)/ delta_t)+(10^-6));
%     [a b] = hist(temp,unique(temp));
%     X(i,b) = a;
%  end
 
%% 
% temp = [];
% time_matrix = cell(size((active_nodes),1),max_el);
% for i = 1:size((active_nodes),1)
%         [temp idx] = sort(datenum(Date_test(active_nodes(i,(1:new_map_index(i))))));
%         a = arrayfun(@(x) datestr(x), temp,'UniformOutput', false);
%         time_matrix(i,(1:new_map_index(i))) = a;
% end

