function [] = draw_quiver(h, x, y, theta)
    r = 0.5;
    
    [u,v] = pol2cart(theta + pi/2, r);
    set(h, 'XData', x, 'YData', y, 'UData', u, 'VData', v);
end
