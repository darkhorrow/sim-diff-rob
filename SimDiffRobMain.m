clc;
clear;

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
xlim([-5 5]);
ylim([-5 5]);

while ishandle(plotGraph)
    [ nx, ny, nt ] = SimDiffRob( cx, cy, ct, it, v, w );
   
    cx = nx;
    cy = ny;
    ct = nt;
    %it = it + 0.1;
    pause(0.01);
    
    cxp(end+1) = cx;
    cyp(end+1) = cy;
    set(plotGraph, 'XData', cxp, 'YData', cyp); 
    
    if sqrt((cx - ax)^2 + (cy - ay)^2) >= 4
        ax = 0;
        ay = 0;
        at = at + pi*0.5;
        
        w = 0.1;
        v = 0;
        while ct < at
            [ nx, ny, nt ] = SimDiffRob( cx, cy, ct, it, v, w );
            cx = nx;
            cy = ny;
            ct = nt;
            %it = it + 0.1;
            pause(0.01);

        end
        
        ax = cx;
        ay = cy;
        
        w = 0;
        v = 0.5;
    end
end
