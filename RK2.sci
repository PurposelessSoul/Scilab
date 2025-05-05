function y = RK2(init, t, f)
    // First order ODE solver using Runkge Kutta 2
    // Params: init: the initial value of the dependent variable (y_0)
    //         t: the time range over which the integration is carried out (t = t_0:h:t_final)
    //         f = right-hand side equation such that $\frac{dy}{dt} = f(t,y)$
    y(1) = init;
    h = t(2) - t(1);
    for i = 1:(length(t)-1)
        k1 = h*f(t(i),y(i));
        k2 = h*f(t(i)+h, y(i)+k1);
        y(i+1) = y(i) + (k1 + k2)/2;        
    end
endfunction