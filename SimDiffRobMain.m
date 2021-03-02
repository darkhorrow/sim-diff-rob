clc;
clear;

hold on;

it = 0.1;
cx = 0;
cy = 0;
ct = 0;
v = 0.5;
w = 0;

ax = 0;
ay = 0;
at = 0;

cxp = [0];
cyp = [0];

plotGraph = plot(cx, cy);
quiverGraph = quiver(cx, cy, ct);
quiverGraph.MaxHeadSize = 10;

plot(0,0, "b*");
plot(0,4, "b*");
plot(-4,4, "b*");
plot(-4,0, "b*");

xlim([-5 1]);
ylim([-1 5]);

n = 0;
expected_theta = 0;

while ishandle(plotGraph) && ishandle(quiverGraph)
    [ nx, ny, nt ] = SimDiffRob( cx, cy, ct, it, v, w );
   
    cx = nx;
    cy = ny;
    ct = nt;
    
    pause(0.01);
    
    cxp(end+1) = cx;
    cyp(end+1) = cy;
    set(plotGraph, 'XData', cxp, 'YData', cyp);
    draw_quiver(quiverGraph, cx, cy, ct);
    
    
    if sqrt((cx - ax)^2 + (cy - ay)^2) >= 4
        at = at + pi*0.5;
        
        w = 0.1;
        v = 0;
        while ct < at
            [ nx, ny, nt ] = SimDiffRob( cx, cy, ct, it, v, w );
            cx = nx;
            cy = ny;
            ct = nt;
            
            pause(0.01);
            draw_quiver(quiverGraph, cx, cy, ct);
        end
        n = mod(n+1, 4);
        expected_theta = expected_theta + (pi/2);
        
        [pos_err, dir_err] = robot_error(cx, cy, ct, expected_theta, n+1);
        fprintf("Position error : %f | Direction error : %f\n", pos_err, dir_err);
        
        ax = cx;
        ay = cy;
        
        w = 0;
        v = 0.5;
    end
end
