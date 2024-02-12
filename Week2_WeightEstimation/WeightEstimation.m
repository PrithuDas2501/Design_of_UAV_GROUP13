%% Entering Data and visualizing it (WE NEED TO DO SOMETHING ABOUT THIS!!!!!)
%Empty_Weight = [8, 5, 3.7, 12, 14.9, 1.95, 11.5, 1.5, 6]; 
%MTOW = [9.5, 10, 4.7, 18, 21.5, 5.9, 14.5, 2.2, 10];
clear; close
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
%% Power Calculation
%% Energy and Battery Weight Fraction Estimation
Mass = 10; %(Can be anything, will be cancelled in the final battery weight estimation)
W = Mass*9.81;
LbyD = 10;

Ptakeoff = (W/LbyD)*1.2*12;
Etakeoff = Ptakeoff*30;

P_climb = (12.5/LbyD)*W;
E_Climb = P_climb*120;

P_CruiseLoit = (20/LbyD)*W;
E_CruiseLoit = P_CruiseLoit*2*60*60;

Total_Energy = 2*Etakeoff + 2*E_Climb + E_CruiseLoit;

Battery_Energy_Density = 260; % W h/ Kg
Battery_Weight = Total_Energy/(Battery_Energy_Density*60*60);
Battery_Weight_Fraction = Battery_Weight/Mass;
display(Battery_Weight_Fraction);
%% Iterative Loop to find initial estimate of weight
A = sol(1);
L = sol(2);
W_p = 1.5; % Kg (We have to find this)
Battery_Weight_Fraction; % (Calculated in Battery Estimation)

figure
hold on
grid on
ylabel('Weight')
xlabel('Iteration Number')
title('Convergence of Weight')
n = 20;
W = linspace(5,15,n);
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
