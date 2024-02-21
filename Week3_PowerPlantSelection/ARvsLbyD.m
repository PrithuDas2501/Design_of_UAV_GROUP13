figure
grid on
hold on
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
Ratio = 5.4; %%%%%%%%%
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
Ratio = 3.9;
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
Ratio = 3.9;
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
Ratio = 2.2;
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
Ratio = 2.2;
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
Ratio = 2.2;
Cd0 = Cf*Ratio;
L_DMax = sqrt(3/(16*K*Cd0));
AR_array(7) = AR;
L_DMax_array(7) = L_DMax;
%%
scatter(AR_array.^0.5,L_DMax_array)
