function [pos_err, dir_err] = robot_error(x, y, ct, et, n)
    pvals = [ 0, 0;
              0, 4;
             -4, 4;
             -4, 0];
    pos_err = sqrt(sum((pvals(n, :) - [x, y]).^2));
    dir_err = abs(ct - et);
end
