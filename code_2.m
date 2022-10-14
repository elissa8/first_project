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

K=sparse(N+1,N+1);
F=zeros(N+1,1);

C0=0;

K(1,1)=-3;
K(1,2)=4;
K(1,3)=-1;
K(N+1,N+1)=1;
F(1,1)=0;
F(N+1,1)=Ce;
for i = 2:N;
        K(i,i-1:i+1) = [d1 -2*d1-d2/(dr*(i-1)) d1+d2/(dr*(i-1))];
        F(i,1) = s;
end

U=K\F;

x=0:dr:R;
hold on
plot(x,U,'DisplayName','numerical solution')


X= (1/4).*(s./Deff).*(x.^2-R^2)+Ce
plot(x,X,'DisplayName','analytical solution')

title('Combine Plots')
xlabel('r-values')
ylabel('y-values')

hold off
% initial value of norme 1 and 2 
L_1 =1/(N+1)*(U(1)-X(1));
L_2=(1/(N+1)*(U(1)-X(1))^2);
% storing in a matrix the error to find the maximum for Linfinity
store = [U(1)-X(1)];
% applying the sum and concatination of matrices
for j=2:N+1
    L_1=L_1+ 1/(N+1)*(U(j)-X(j));
    L_2=L_2+ (1/(N+1)*(U(j)-X(j))^2);
    
    store(j)=[U(j)-X(j)];
   
end
% displaying the norms
L_1
L_2=L_2^0.5
L_3=max(store)