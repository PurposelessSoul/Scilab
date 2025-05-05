exec("C:\Users\nahom\Desktop\Scilab\ODE_Euler.sci", -1);
exec("C:\Users\nahom\Desktop\Scilab\RK2.sci", -1);
exec("C:\Users\nahom\Desktop\Scilab\RK4.sci", -1);


T_half = 5; //The half-life
"$\frac{dN}{dt} = -\lambda \cdot N$" //Where Lambda is a constant given as:
lambda = 0.693/T_half;
N_0 = 200; //Initial number of radioactive particles

function N_dot = f(t, N, lambda)
    N_dot = -lambda * N;
endfunction

t = 0:T_half:50;
N_ans = N_0 * exp(-lambda*t);
N1 = ODE_Euler(N_0, t, f);
N2 = RK2(N_0, t, f);
N3 = RK4(N_0, t, f)
N4 = ode(N_0, 0, t, f);

clf;
True_sol = plot(t, N_ans, 'b');
Euler = plot(t, N1, 'r--');
RK2_p = plot(t, N2, 'g--');
RK4_p = plot(t, N3, 'm--');
sci_ode = plot(t, N4, 'o.');

T = title("$\frac{dN}{dt} = -\lambda \cdot N$");
T.font_size = 4;
xlabel "t" font_size 4;
ylabel "N" font_size 4;
legend([True_sol Euler RK2_p RK4_p sci_ode], 'Analytical solution', 'Eulers Method', 'RK2','RK4', 'scilabs ode()');
xgrid();
