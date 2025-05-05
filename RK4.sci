function y = RK4(init, t, f)
    /* Runge kutta 4th order integrater for 1st order ODE:
        Params: init = y_0
                t = integration time (t = t_0:h:t_final)
                f = right hand side equation such that "$\frac{dy}{dt} = f(t,y)$"
    */
    y(1) = init;
    h = t(2) - t(1);
    for i = 2:length(t)
        k1 = h*f(t(i-1), y(i-1));
        k2 = h*f(t(i-1)+h/2 , y(i-1) + k1/2);
        k3 = h*f(t(i-1)+h/2, y(i-1) + k2/2);
        k4 = h*f(t(i-1)+h, y(i-1)+k3);
        y(i) = y(i-1) + 1/6*(k1 + 2*k2 + 2*k3 + k4);
    end

endfunction

