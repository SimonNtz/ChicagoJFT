function [delta_t,start_count] = timeformat(Date,f)
% Set the first date as the start of our time format
start_count = min(datenum(Date));
% Set time format according to argument f
switch f
    case 'day'
        delta_t = 1;
    case 'week'
        delta_t = 7;
    case 'month'
        delta_t = 30;
    case 'year'
        delta_t = 365;
    otherwise
        disp('wrong time format')
end
end

