function [pos_err, dir_err] = robot_error(x, y, ct, et, pvals, n )
    
    pos_err = sqrt(sum((pvals(n, :) - [x, y]).^2));
    dir_err = abs(ct - et);
end
