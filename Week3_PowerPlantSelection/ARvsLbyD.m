clear all; close all
figure
grid on
hold on
xlabel('AR^0^.^5')
ylabel('L/D at Min Power')
axis([0 6 15 40])
nu = 15.53e-6;
AR_array = [0 0 0 0 0 0 0];
L_DMax_array = [0 0 0 0 0 0 0];
%% Boeing Insitu
HalfWing = 1.6;
S = 2*1.6*0.2;
b = 2*HalfWing;
AR = b^2/S;
sweep = 20;
e = 1.78*(1-0.045*AR^0.68)-0.64;
V = 28.3;
K = 1/(pi*e*AR);
c = 0.3;
Re = V*c/nu;
Cf = 1.328/sqrt(Re);
Ratio = 2.86; %%%%%%%%%
Cd0 = Cf*Ratio;
L_DMax = sqrt(3/(16*K*Cd0));
AR_array(1) = AR;
L_DMax_array(1) = L_DMax;
%scatter(sqrt(AR),L_DMax);
%% RQ 20 Puma
b = 2.8;
S = 0.8;
AR = 9.8;
V = 18;
sweep = 0;
e = 1.78*(1-0.045*AR^0.68)-0.64;
K = 1/(pi*e*AR);
c = 0.25439;
Re = V*c/nu;
Cf = 1.328/sqrt(Re);
Ratio = 2.48;
Cd0 = Cf*Ratio;
L_DMax = sqrt(3/(16*K*Cd0));
AR_array(2) = AR;
L_DMax_array(2) = L_DMax;
%scatter(sqrt(AR),L_DMax);
%% Albatross
b = 15;
A = 12.26;
c = 0.23;
AR = 18.3;
sweep = 0;
e = 1.78*(1-0.045*AR^0.68)-0.64;
K = 1/(pi*e*AR);
V = 55.56;
Re = V*c/nu;
Cf = 1.328/sqrt(Re);
Ratio = 2.43;
Cd0 = Cf*Ratio;
L_DMax = sqrt(3/(16*K*Cd0));
AR_array(3) = AR;
L_DMax_array(3) = L_DMax;
%scatter(sqrt(AR),L_DMax);
%% Random Plane (HASA)
b = 2.36;
S = 0.733;
AR = 7.603;
c = 0.371;
V = 30;
sweep = 30;
e = 1.78*(1-0.045*AR^0.68)-0.64;
K = 1/(pi*e*AR);
Re = V*c/nu;
Cf = 1.328/sqrt(Re);
Ratio = 2.2;
Cd0 = Cf*Ratio;
L_DMax = sqrt(3/(16*K*Cd0));
AR_array(4) = AR;
L_DMax_array(4) = L_DMax;
%scatter(sqrt(AR),L_DMax);
%% CM Furia
b = 2;
S = 0.3;
AR = 13.33;
c = 0.2;
V = 18;
sweep = 15;
e = 1.78*(1-0.045*AR^0.68)-0.64;
K = 1/(pi*e*AR);
Re = V*c/nu;
Cf = 1.328/sqrt(Re);
Ratio = 2.397;
Cd0 = Cf*Ratio;
L_DMax = sqrt(3/(16*K*Cd0));
AR_array(5) = AR;
L_DMax_array(5) = L_DMax;
%scatter(sqrt(AR),L_DMax);
%% Borey 20
b = 4.3;
S = 1.59;
AR = 12;
c = 0.36;
V = 20;
sweep = 20;
e = 1.78*(1-0.045*AR^0.68)-0.64;
K = 1/(pi*e*AR);
Re = V*c/nu;
Cf = 1.328/sqrt(Re);
Ratio = 2.1;
Cd0 = Cf*Ratio;
L_DMax = sqrt(3/(16*K*Cd0));
AR_array(6) = AR;
L_DMax_array(6) = L_DMax;

%% Crex B
rootc = 0.26;
S  = 2*1870e-2;
b = 170e-2;
AR = 7.62;
V =  10;
sweep = 20;
e = 1.78*(1-0.045*AR^0.68)-0.64;
K = 1/(pi*e*AR);
c = 0.2253;
Re = V*c/nu;
Cf = 1.328/sqrt(Re);
Ratio = 2.5;
Cd0 = Cf*Ratio;
L_DMax = sqrt(3/(16*K*Cd0));
AR_array(7) = AR;
L_DMax_array(7) = L_DMax;
%%
scatter(AR_array.^(0.5),L_DMax_array)
%% Mean of L/D and Updated Power Estimation
Mean_LbD = sum(L_DMax_array)/length(L_DMax_array)
Corresponding_AR = ((Mean_LbD -3.55)/8.038)^2
e = 1.78*(1-0.045*Corresponding_AR^0.68)-0.64
K = 1/(pi*e*Corresponding_AR)
c = 0.2253;
V = 20;
Re = V*c/nu;
Cf = 1.328/sqrt(Re);
Cd0 = Cf*3
V_RCMax = 15

Mass = 10.21; % From Week 2 Estimate
W = Mass*9.81;
Power_during_climb = 380.7550961;
%% Entering Data and visualizing it (WE NEED TO DO SOMETHING ABOUT THIS!!!!!)
%Empty_Weight = [8, 5, 3.7, 12, 14.9, 1.95, 11.5, 1.5, 6]; 
%MTOW = [9.5, 10, 4.7, 18, 21.5, 5.9, 14.5, 2.2, 10];
MTOW = [10,27,5.5,35,12,9,5,26];
Empty_Weight = [4.4,14,3.5,20,9,6.2,3.5,8.7];

x = linspace(5,50,100);
figure
hold on
grid on
scatter(MTOW,Empty_Weight./MTOW)
% plot(x,y)

%  Finding A, L by curve fitting
sol = fmincon(@(X) find_AL(X,MTOW,Empty_Weight./MTOW),[1,0])
y = sol(1)*x.^sol(2);
plot(x,y,LineWidth=2)
title('Empty Weight Fraction Vs Total Weight Trend')
xlabel('Wt')
ylabel('We/Wt')
%% Energy and Battery Weight Fraction Estimation
Mass = 10.21; %(Can be anything, will be cancelled in the final battery weight estimation)
W = Mass*9.81;
LbyD = Mean_LbD;

Ptakeoff = (0.5*10.21*14.4^2)/10 + 14.4*10.21*9.81/LbyD
Etakeoff = Ptakeoff*10;

P_climb = Power_during_climb
E_Climb = P_climb*120;

P_CruiseLoit = (20/(LbyD))*W
E_CruiseLoit = P_CruiseLoit*2*60*60;

P_Turn = 27*3*W/((LbyD))
E_Turn = P_Turn*90;

Total_Energy = 2*Etakeoff + 2*E_Climb + E_CruiseLoit + E_Turn

Battery_Energy_Density = 200; % W h/ Kg
Battery_Weight = Total_Energy*1.1/(0.8*0.8*Battery_Energy_Density*60*60);
Battery_Weight_Fraction = Battery_Weight/Mass;
display(Battery_Weight_Fraction);
%% Iterative Loop to find initial estimate of weight
A = sol(1);
L = sol(2);
W_p = 2.5; % Kg (We have to find this)
Battery_Weight_Fraction; % (Calculated in Battery Estimation)

figure
hold on
grid on
ylabel('Weight')
xlabel('Iteration Number')
title('Convergence of Weight')
n = 20;
W = linspace(5,35,n);
for k = 1:n
    w1 = W(k); % Kg (Just an initial guess)
    i = 1;
    diff = 10;
    array = zeros(1,2);
    array = [i w1];
    while abs(diff)>0.00001 
        empty_frac = find_empty_frac(A,L,w1);
        w2 = W_p/(1-Battery_Weight_Fraction-empty_frac); 
        diff = (w2-w1)/w1;
        w1 = w2;
        i=i+1;
        array(i,:) = [i w1];
        if i>100
            break
        end
    end
    % display(w1)
    plot(array(:,1),array(:,2), 'Color','b')
end
w1
%%
function y = find_empty_frac(A,L,W)
y = A*W.^L;
end

function cost = find_AL(X,MW,frac)
A = X(1);
L = X(2);
y = A*MW.^L;
error = (frac-y)./y;
cost = error*error';
end
