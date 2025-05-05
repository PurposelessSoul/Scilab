clear;
exec("C:\Users\nahom\Desktop\Scilab\draw_vector.sci",-1);

//We can use the spec() function to find the eigenvalues and eigenvectors of matrices

A = [1.5 -1;-1 1.5];
[T, D] = spec(A)
//Each column of T is an eigenvector and D is a diagonal matrix whose entries are the eigenvalues
//What makes these vectors special is that when transformed by A, they don't change their direction.

v(1,:) = [1 0]; 
v(2,:) = [0 1];   //Definig random vectors to transform ...
v(3,:) = [1 3]; 
v(4,:) = [3 1]; 

for i = 1:4
    v(i,:) = v(i,:)/norm(v(i,:));    
end

for i = 5:8
    v(i,:) = -v(i-4,:);
end

for i = 1:8
    V(i,:) = A*v(i,:)';
end


scf(1);
for i = 1:8
    draw_vector([0 0], v(i,:),i);
    draw_vector([0 0], V(i,:), i);
end
draw_vector([0 0], T(:,1)',2); draw_vector([0 0], T(:,2)', 3);
draw_vector([0 0], (A*T(:,1))',2); draw_vector([0 0], (A*T(:,2))', 3);

xstring(T(1,1),T(2,1),'T1'); xstring(T(1,2), T(2,2), 'T2');
xstring((A*T(:,1))(1),(A*T(:,1))(2),'T1 transformed'); xstring((A*T(:,2))(1),(A*T(:,2))(2),'T2 transformed');
//You can see that the two special vectors, the eigenvectors, are only scaled up after the transformation.
//And their scale factor is the eigen values of the transformation matrix, A.

//Example: We can try solving the system "$\dot x = A*x$"

function x = func(t_, init)
    E = zeros(D);
    for i = 1:length(D(1,:))
        E(i,i) = exp(D(i,i)*t_)
    end
    x = (T*E*T^-1)*init
endfunction

k = 0;
for i = -1:0.5:1
    for j = -1:0.5:1
        k = k+1;
        inits(:,k) = [i;j]    //storing every grid point defined by -1<x<1 and -1<y<1 in steps of 0.5 as an init
    end
end

t = linspace(0, 1, 10);
scf(2);
for j = 1:k
    for i = 1:length(t)
        X(:,i) = func(t(i),inits(:,j));  //storing the solution in a 2xlength(t) matrix
    end
    plot2d4(X(1,:), X(2,:)) //displaying the solution to the kth init point over t.
end
isoview on;
gca.x_location = 'origin';
gca.y_location = 'origin';




scf(3);
// Define the function
deff("xy_dot = f(t, xy)", ["xy_dot = A*xy"]);

x1_range = -5:0.5:5;
x2_range = -5:0.5:5;

// Call fchamp with the correct function format
h = fchamp(f, 10, x1_range, x2_range,1.5,[-10, -6, 10, 6]); 
//vector field solution to the ode $\[\begin{pmatrix} \dot x \\ \dot y \end{pmatrix}\] = \[\begin{pmatrix} -3 && -1 \\ -1 && -3  \end{pmatrix} \[\begin{pmatrix} x \\ y \end{pmatrix} $
h.colored = "on"; colorbar;
colormap(jet);
isoview on;
gca.x_location = 'origin';
gca.y_location = 'origin';
plot(6*[-T(1,1) T(1,1)], 6*[-T(2,1) T(2,1)]);  //Plot the eigenvector axis
plot(6*[-T(1,2) T(1,2)], 6*[-T(2,2) T(2,2)]);
gcf.background = -2;   //Make the background white

