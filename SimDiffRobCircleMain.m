clc;
clear;

hold on;



it = 0.1;
cx = 0;
cy = 0;
ct = 0;

temp_v = 0;
max_vel = 0.5;
v = 0.1;
w = 0.1;

acel = 0;

ax = 0;
ay = 0;
at = 0;

cxp = [0];
cyp = [0];

plotGraph = plot(cx, cy);
quiverGraph = quiver(cx, cy, ct);
quiverGraph.MaxHeadSize = 10;

xlim([-2 0]);
ylim([-1 1]);

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
    
end
