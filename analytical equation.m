clear all;
clc;
Ce=10;
R=0.5;
k=4*10^(-9);
s= 10^(-8);
Deff= 10^(-10);

N=4;
dr=R/N;

for j =1:N+1;
    X= (1/4)*(s/Deff)*((dr*(j-1))^2-R^2)+Ce
end