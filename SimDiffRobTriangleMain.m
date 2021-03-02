clc;
clear;
clf;

hold on;

pvals = [ 0, 0;
          0,  4;
          -sqrt(12), 2];

it = 0.1;
cx = 0;
cy = 0;
ct = 0;

temp_v = 0;
max_vel = 0.5;
v = 0.1;
w = 0;

acel = 0.01;

ax = 0;
ay = 0;
at = 0;

cxp = [0];
cyp = [0];

plotGraph = plot(cx, cy);
quiverGraph = quiver(cx, cy, ct);
quiverGraph.MaxHeadSize = 10;

plot(pvals(:,1), pvals(:,2), "b*");

xlim([-5 1]);
ylim([-1 5]);

n = 0;
expected_theta = 0;

while ishandle(plotGraph) && ishandle(quiverGraph)
    [ nx, ny, nt ] = SimDiffRob( cx, cy, ct, it, v, w );
   
    cx = nx;
    cy = ny;
    ct = nt;
    
    pause(it);
    
    cxp(end+1) = cx;
    cyp(end+1) = cy;
    set(plotGraph, 'XData', cxp, 'YData', cyp);
    draw_quiver(quiverGraph, cx, cy, ct);
    
    if v + acel <= max_vel
        v = v + acel;
    else
        v = max_vel;
    end
    
    
    if sqrt((cx - ax)^2 + (cy - ay)^2) >= 4
        at = at + 120*pi/180;
        
        temp_v = v;
        w = 0.1;
        v = 0;
        while ct < at
            [ nx, ny, nt ] = SimDiffRob( cx, cy, ct, it, v, w );
            cx = nx;
            cy = ny;
            ct = nt;
            
            pause(it);
            draw_quiver(quiverGraph, cx, cy, ct);
        end
        n = mod(n+1, 3);
        expected_theta = expected_theta + 120*pi/180;
        
        [pos_err, dir_err] = robot_error(cx, cy, ct, expected_theta, pvals, n+1);
        fprintf("Position error : %f | Direction error : %f\n", pos_err, dir_err);
        
        ax = cx;
        ay = cy;
        
        w = 0;
        v = temp_v;
    end
    
end
