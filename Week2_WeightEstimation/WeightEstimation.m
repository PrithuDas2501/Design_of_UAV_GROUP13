%% Entering Data and visualizing it (WE NEED TO DO SOMETHING ABOUT THIS!!!!!)
%Empty_Weight = [8, 5, 3.7, 12, 14.9, 1.95, 11.5, 1.5, 6]; 
%MTOW = [9.5, 10, 4.7, 18, 21.5, 5.9, 14.5, 2.2, 10];
MTOW = [10,27,5.5,35,12,7];
Empty_Weight = [4.4,14,3.5,20,9,4.2];


p = polyfit(MTOW, Empty_Weight./MTOW, 2);
x = linspace(0,50,100);
y = p(1)*x.^2 + p(2)*x + p(3);

figure
hold on
scatter(MTOW,Empty_Weight./MTOW)
plot(x,y)

%% Finding A, L by curve fitting
sol = fmincon(@(X) find_AL(X,MTOW,Empty_Weight./MTOW),[1,0]);
find_AL(sol,MTOW,Empty_Weight./MTOW);
%% Power Calculation
P = 0;
% Take off and Landing
% Taking L/D at cruise to be 7, T = W/7
% Assuming Vliftoff is 1.15 times Vstall, and assuming that power
% requirement can be taken by considering the V during the take off run to
% be 0.7 times Vliftoff.
% From previous literature, we take Vstall to be Vstall = 12m/s
Vaveragetakeoff = 0.7*1.15*12;
W = 10*9.81;
LbyD = 7;
T = W/LbyD;
Ptakeoff = T*Vaveragetakeoff;
Etakeoff = Ptakeoff*30;
Energy = 2*Etakeoff;

%P = 
%% Iterative Loop to find initial estimate of weight
A = sol(1);
L = sol(2);
W_p = 3; % Kg (We have to find this)
battery_frac= 0.215; % (We have to find this)

w1 = 10; % Kg (Just an initial guess)
i = 1;
diff = 10;
figure
array = [i w1];
hold on
grid on
while abs(diff)>0.001 
    empty_frac = find_empty_frac(A,L,w1);
    w2 = W_p/(1-battery_frac/w1-empty_frac); 
    diff = (w2-w1)/w1;
    w1 = w2;
    i=i+1;
    array(i,:) = [i w1];
    if i>100
        break
    end
end
plot(array(:,1),array(:,2))

display(w1)

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

