% create a 2D graph (sensor network) of N nodes.
           
           N = 256; T=1;
           G = gsp_sensor(N);
           G = gsp_jtv_graph(G, T);
           G = gsp_compute_fourier_basis(G);

           % an example of a time-vertex signal
           X = agg_cell_map;

           % Do a JFT
           X_JFT = gsp_jft(G, X);

           figure; gsp_plot_signal(G, X(:,2));
           param.show_edges = 0;
           param.step = 1;
           %figure;
           %gsp_plot_jtv_signal(G, X, param);
           %% show the spectrum
           imagesc(fftshift(abs(X_JFT), 2));  
            
          % more elaborate plot
            param.logscale = 1;      % log/db scale
            param.dim        = '2d';   % plot a 3D figure
            param.NFFT     = 1024; % upsample the number of frequency points in the time domain
            gsp_plot_jft(G, X_JFT, param);