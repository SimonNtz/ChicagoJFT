% Clean the Vector X and Y of NaN or 0 value and return
% also the new (cleaned)sample index.

function [X,Y,idx] = data_clean(x,y)

% Zero handling
if ( find(x == 0) == find(y == 0) )
    idx = (x==0);
else
    idx = (x==0) | (y==0);
end

% Nan handling
if find(isnan(x)) == find(isnan(y))
    idx = idx | isnan(x);
else
    idx = idx | isnan(x) | isnan(y) ; 
end  
    X   = x(~idx);
    Y   = y(~idx);
    idx = ~idx;
end