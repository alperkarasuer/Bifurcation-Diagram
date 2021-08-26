%Plots bifurcation diagram for given equation
%Calculations are not generalized so works only for equations with three or
%less fixed points at a given r.
%Equations in line 17 and 27 must be the same.
tic
clearvars
close
syms x rVal

r = -5:0.1:5; %Range and resolution for r values.

imperfectionParam = 0; % Imperfection parameter h

S = NaN(length(r),4); %matrix for fixed points

%Find fixed points for all r values
for i = 1:length(r)
eqn = imperfectionParam + r(i)*x-x^3; %Equation to be plotted
S(i,2:4) = solve(eqn,x,'Real',true);
S(i,1) = r(i);
fprintf('\nFound %d out of %d points',i,length(r));
end

%% Classification of fixed points
solns = [S(:,[1 2]);S(:,[1 3]);S(:,[1 4])]; %flatten solutions matrix
solns = unique(solns,'rows'); % remove duplicate solutions if any

func = @(x) imperfectionParam + rVal*x-x^3; %Equation to be plotted
for i = 1:length(solns)
    solns(i,3) = eval((subs(diff(func,x,1),[x, rVal],[solns(i,2),solns(i,1)]))); %evaluate derivative at point
    fprintf('\nCalculating derivative for %d out of %d points',i,length(solns));
end

%classify fixed points using linear stability analysis
stableIdx = find(solns(:,3) < 0);
unstableIdx = find(solns(:,3) > 0);
undeterminedIdx = find(solns(:,3) == 0);

stablePoints = solns(stableIdx,1:2);
unstablePoints = solns(unstableIdx,1:2);
undeterminedPts = solns(undeterminedIdx,1:2);

t_elapsed = toc;
fprintf('\nTime elapsed %.2f',t_elapsed);

%% Plot
figure()
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
plot(stablePoints(:,1),stablePoints(:,2),'rx','MarkerSize',10); %stable fixed points
hold on 
plot(unstablePoints(:,1),unstablePoints(:,2),'kx','MarkerSize',10); %unstable fixed points
plot(undeterminedPts(:,1),undeterminedPts(:,2),'gx','MarkerSize',10); %derivative 0, stability can't be determined with this method
line([0,0], ylim, 'Color', 'k', 'LineWidth', 0.8); % Draw line for Y axis.
line(xlim, [0,0], 'Color', 'k', 'LineWidth', 0.8); % Draw line for X axis.
grid minor
legend('Stable','Unstable','Undetermined')







