

%% Load data
filename = 'test3_stats.xlsx';
sheet = 1;
xlRange = 'A1:B616';
subsetA = xlsread(filename,sheet,xlRange);
%% Clean Data
nf = 6; % number of features loaded

subsetA = subsetA(~isnan(subsetA));
subsetA_M = reshape(subsetA',[6, 77])';

mean_ethn = mean(subsetA_M,1);
std_ethn  = std(subsetA_M, 1);
%% First visualization 
%% mean and standard deviation
figure
scatter(1:6,mean_ethn, 'filled');
hold on
scatter(1:6,std_ethn, 'filled');

%[a, b]= sort(std_ethn);
%% ethnicity distribution per CA
figure
plot(1:77,subsetA_M(:,3:5),'LineWidth', 1.5);
legend('black', 'hispanic', 'white');
figure
plot(1:77,subsetA_M(:,[2,6]), 'LineWidth', 1.5);
legend('asian', 'other');
%% Normalization
subsetA_M = bsxfun (@rdivide, subsetA_M, subsetA_M(:,1));
%% Features selection
subsetA_M = subsetA_M(:, [1, 3 , 4, 5]);

%% Get adjacency_matrix W from a exponential kernel
t   = 1e-5;
std =  1e-1 * .5;                   %1e4*0.8;

W   = get_adjacency_matrix(subsetA_M, std, t);
imagesc(W);
%% Graph initialization
G = gsp_graph(W,subsetA_M);
G = gsp_compute_fourier_basis(G);
G = gsp_jtv_graph(G,size(X,2));
%% Compute spectrum
X_GFT = gsp_gft(G, X);
X_JFT = gsp_jft(G, X);

%% Visualization
%% - GFT
figure
gsp_plot_signal_spectral(G, mean(X_GFT,2))
%% - JFT
X_JFT = X_JFT - mean(X_JFT(:));
figure
param = struct;
param.logscale = 1;      % log/db scale
param.dim        = '3d';   % plot a 3D figure
% param.NFFT     = 1024; % upsample the number of frequency points in the time domain
gsp_plot_jft(G, X_JFT, param);
xlabel('\lambda_l')
ylabel('\omega')

%% Show graph and W
figure 
imagesc(W);
figure;
param.vertex_size = 100; 
param.show_edges = 1;
gsp_plot_signal(G, mean(X,2),param)


%% Import Labels

fid = fopen('test4.csv');
C_headers = textscan(fid,'%s',1);
format = '%s %s';
test_data = textscan(fid, '%s', 'headerlines',1,'delimiter',',');
fclose(fid);
%%
