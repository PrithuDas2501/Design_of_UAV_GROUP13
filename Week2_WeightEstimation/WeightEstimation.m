%% Entering Data and visualizing it (WE NEED TO DO SOMETHING ABOUT THIS!!!!!) 
Empty_Weight = [8, 5, 3.7, 12, 14.9, 1.95, 11.5, 1.5, 6];
MTOW = [9.5, 10, 4.7, 18, 21.5, 5.9, 14.5, 2.2, 10];

p = polyfit(MTOW, Empty_Weight./MTOW, 2);
x = linspace(0,25,100);
y = p(1)*x.^2 + p(2)*x + p(3);

figure
hold on
scatter(MTOW,Empty_Weight./MTOW)
plot(x,y)

%% Finding A, L by curve fitting
sol = fmincon(@(X) find_AL(X,MTOW,Empty_Weight./MTOW),[1,-0.5]);
%% Iterative Loop to find initial estimate of weight

W_p = 3; % Kg (We have to find this)
battery_frac = 0.25; % (We have to find this)

w1 = 10; % Kg (Just an initial guess)
i = 1;
diff = 10;
figure
array = [i w1];
hold on
grid on
while abs(diff)>0.001 
    empty_frac = find_empty_frac(1,-0.5,w1);
    w2 = W_p/(1-battery_frac-empty_frac); 
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

