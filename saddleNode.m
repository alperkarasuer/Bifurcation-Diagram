clearvars
syms x

r = -5:0.1:5;
rootsArray = zeros(length(r),3);

for i = 1:length(r)
eqn = r(i) + x^2;
coefs = sym2poly(eqn);
solns = roots(coefs)'
rootsArray(i,1) = r(i);
if (isreal(solns))
    rootsArray(i,2:3) = solns;
else
    rootsArray(i,2:3) = [NaN, NaN];
end
end



plot(rootsArray(:,1),rootsArray(:,2),'ro')
grid minor
hold on
plot(rootsArray(:,1),rootsArray(:,3),'go')