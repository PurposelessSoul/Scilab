

function y = ODE_Euler(init, t, f)
    /* The most basic method to solve ODE's numerically
    params: 
            init = y_0
            t = integration time range (t = t_0:h:t_final)
            f = a function of y and t such that 
                        $\frac{dy}{dx} = f(y,x)$     */
    
    y(1) = init;
    h = t(2) - t(1);
    for i = 2:length(t)
        y(i) =  y(i-1) + h*f(t(i-1),y(i-1));
    end
endfunction

