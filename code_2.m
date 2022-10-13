clc;
clear all;
Ce=10;
R=0.5;
k=4*10^(-9);
s= 10^(-8);
Deff= 10^(-10);

N=4;
dr=R/N;



d1= (Deff)/(dr^2);
d2= Deff/dr;

K=zeros(N+1,N+1);
F=zeros(N+1,1);

C0=0;

K(1,1)=-3;
K(1,2)=4;
K(1,3)=-1;
K(N+1,N+1)=1;
F(1,1)=0;
F(N+1,1)=Ce;
for i = 2:N;
        K(i,i-1:i+1) = [d1 -2*d1-d2/(dr*(i-1)) d1+d2/(dr*(i-1))]
        F(i,1) = s;
end

U=K\F