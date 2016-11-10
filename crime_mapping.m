function [clust_xy] = crime_mapping(x, y, s)

C = {'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6]};
j = 1;
% plot first point to load the map
for i = 1:s:10000
    
    lon = x(i:i+s); 
    lat = y(i:i+s); 
    
    plot(lon,lat,'.','color',C{j},'MarkerSize',8);
    plot_google_map;
    if i == 1
        pause(3)
    end
    hold on
    j = mod((j + 1),7)+1;
    pause(0.4);
end
end















