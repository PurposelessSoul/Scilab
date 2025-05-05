exec("C:\Users\nahom\Desktop\Scilab\draw_vector.sci",-1);
//Given...
L1 = 10; L2 = 4; L3 = 10; L4 = 12;
theta2 = 120; omega2 = 45;
//Step 1 is to find theta3 and theta4...
//Lets use graphical method first...
clf;
scf(0);
gca.x_location = 'origin'; gca.y_location = 'origin';
isoview on;
//function to convert rad to deg and vice versa
rad2deg = #(theta) -> (theta*180/%pi);
deg2rad = #(theta) -> (theta*%pi/180);

A = L2*[cos(deg2rad(theta2));sin(deg2rad(theta2))];
scatter(A(1),A(2));
xstring(A(1),A(2),'A');
plot([0,A(1)],[0,A(2)],'r'); //Plotting link 2
xarc(A(1)-L3,A(2)+L3,2*L3,2*L3,0,360*64); //Plotting a circle of radius L3 around A (i.e, all the possible positions of B)
O4 = [L1;0];
scatter(O4(1),O4(2));
xstring(O4(1),O4(2),'O4');
xarc(O4(1)-L4,O4(2)+L4,2*L4,2*L4,0,360*64); //Plotting a circle of radius L4 around O4.
//We see that there are two intersection points, meaning there are two possible positions for B
//One value for B is...
B = [4.785;10.79];
scatter(B(1),B(2)); xstring(B(1),B(2),'B');
//Finally, we connect A, B and O4 to complete the linkage...
plot([A(1),B(1),O4(1)],[A(2),B(2),O4(2)],'r');
//We can then easily find theta3 and theta4 using some vector algebra and trig...
AB = B - A;
theta3 = atan(AB(2)/AB(1)); //in radians
theta3 = rad2deg(theta3);  //in degrees
O4_B = B - O4;
theta4 = atan(O4_B(2)/O4_B(1)); //in radians
theta4 = rad2deg(theta4); //in degrees
title('Position analysis of fourbar using graphical method')

//Next step is velocity analysis to find omega3 and omega4
//We can use the relative velocity method graphically...
scf(2); //opening a new graphic window
clf(2);
Va = L2*omega2; //the scalar speed at A
V_A = Va*[cos(deg2rad(theta2+90));sin(deg2rad(theta2+90))]; //Velocity of A. We add 90 because omega2 is CCW
v1=draw_vector([0 0],V_A',5,0); //drawing a vector from origin to V_A
v1.arrow_size_factor = 2;

//Now, for the next part, to find omega3 and omega 4, we need to find VB_A (B relative to A) and VB (absolute, about O4). I only know the direction of VB_A and VB so we can plot then as lines...
deff(['[] =line(p,a)'],['a = deg2rad(a)','q1 =p+500*[cos(a);sin(a)]',...
'q2 =p-500*[cos(a);sin(a)]','plot([q1(1),q2(1)],[q1(2),q2(2)])'])
line(V_A,theta3+90); //All possible values of VB_A
line([0;0],theta4+90); //all possible values of VB
//We then find the intersection point and label it B
V_B = [-166;-80]; //Velocity of B in vector form

//Finally, we complete the velocity triangle by drawing the remaining vectors...
VB_A = V_B - V_A;
v2=draw_vector(V_A',VB_A',6,0);
v3=draw_vector([0 0],V_B',3,0);
v2.arrow_size_factor = 2;
v3.arrow_size_factor = 2;
//Finally, we find omega3 and omega4 by taking the magnitude of the velocities and dividing them by the link lengths...
Vb_a = norm(VB_A); //scalar
Vb = norm(V_B);
omega3 = Vb_a/L3; omega4 = Vb/L4; //in [rad/s]
title('Velocity analysis of Fourbar linakge using graphical method')
legend([v1,v2,v3],['V_A','V_BA (velocity of B relative to A)','V_B (Absolute velocity of B)'])


