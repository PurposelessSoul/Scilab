exec('C:\Users\nahom\Desktop\Scilab\draw_vector.sci',0)

//Math...
y1 = -13; y2 = -1.01;
g = 9.81;
//m1 = 1; m2 = 2;
//a = g*(m1-m2)/(m1+m2);
t_ = 7;
a = -2*12/t_^2;
t = 0:0.05: 15;
s1 = y1 - 1/2*a*t.^2;
s2 = y2 + 1/2*a*t.^2;
v1 = -a*t;
v2 = a*t;

//Plot...

for i = 1:length(t)
    drawlater();
    clf();
    plot([-1 -1],[0 s1(i)]);   //left string
    plot([1 1], [0 s2(i)]);   //right string
    ax = gca();
    ax.x_location = 'origin';
    ax.y_location = 'origin';
    xarc(-1,1,2,2,0,360*64);
    xrect(-1.5,s1(i),1,1);
    xrect(0.5,s2(i),1,1);
    t1 = xstring(-1 -0.5,s1(i)-2,'$m_1$');
    t2 = xstring(1 - 0.5,s2(i)-2,'$m_2$');
    t1.font_size = 4;
    t2.font_size = 4;
    draw_vector([-2 s1(i)], [0 v1(i)],5); //v1 as a vector
    draw_vector([2 s2(i)-1], [0 v2(i)],5); //v2 as a vector
    t1 = xstring(-2,s1(i)+v1(i),'$v_1$');
    t2 = xstring(2,s2(i)+v2(i),'$v_2$');
    t1.font_size = 4;
    t2.font_size = 4;
    ax.data_bounds = [-10,10,-15,5];
    isoview on;
    drawnow();
    if s2(i) >= -1 | s1(i) >= -1 then
        break;        
    end
end

y_min = min(s1(i)+v1(i), s2(i)+v2(i));
y_max = max(s1(i)+v1(i), s2(i)+v2(i));

ax.data_bounds = [-10,10,y_min-2,y_max+2];
gcf;
title("Atwood Machine");


